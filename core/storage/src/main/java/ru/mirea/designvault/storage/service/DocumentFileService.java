package ru.mirea.designvault.storage.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import io.minio.*;
import io.minio.messages.Item;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import ru.mirea.designvault.storage.exception.DocumentRetrievalException;
import ru.mirea.designvault.storage.model.Document;
import ru.mirea.designvault.storage.model.DocumentFile;
import ru.mirea.designvault.storage.model.DocumentVersion;
import ru.mirea.designvault.storage.repository.DocumentRepository;
import ru.mirea.designvault.storage.repository.DocumentVersionRepository;
import ru.mirea.designvault.storage.repository.projection.DocumentVersionProjection;

import java.io.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.Normalizer;
import java.time.Instant;
import java.util.List;
import java.util.Locale;
import java.util.Optional;
import java.util.UUID;
import java.util.function.Function;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;


@Slf4j
@Service
public class DocumentFileService {
    private final MinioClient minio;
    private final String bucket;
    private final DocumentRepository documentRepository;
    private final DocumentVersionRepository documentVersionRepository;

    public DocumentFileService(MinioClient minio,
                               @Value("${minio.bucket}") String bucket, DocumentRepository documentRepository, DocumentVersionRepository documentVersionRepository) throws Exception {
        this.minio = minio;
        this.bucket = bucket;
        this.documentRepository = documentRepository;
        this.documentVersionRepository = documentVersionRepository;
        boolean exists = minio.bucketExists(BucketExistsArgs.builder().bucket(bucket).build());
        if (!exists) {
            minio.makeBucket(MakeBucketArgs.builder().bucket(bucket).build());
        }
    }

    public DocumentFile getDocumentVersion(UUID pid, UUID did, Integer ver) {
        try {
            Integer targetVersion = resolveVersion(pid, did, ver);
            String objectPath = String.format("%s/%s/%d/content", pid, did, targetVersion);
            DocumentVersionProjection document = documentVersionRepository.findByPidAndDidAndVer(pid, did, targetVersion);
            if (document == null) {
                throw new DocumentRetrievalException("Документ не найден по заданной версии", null);
            }
            InputStream is = minio.getObject(
                    GetObjectArgs.builder()
                            .bucket(bucket)
                            .object(objectPath)
                            .build()
            );
            log.debug("Версия документа получена: pid={}, did={}, version={}", pid, did, targetVersion);

            String name = Optional.ofNullable(document.getFilename()).orElse("document") +
                    "." +
                    Optional.ofNullable(document.getExt()).orElse("bin");
            return DocumentFile.builder()
                    .name(name)
                    .contentType(document.getContentType())
                    .stream(is)
                    .build();
        } catch (Exception e) {
            log.error("Ошибка при получении версии документа: cid={}, did={}, version={}", pid, did, ver, e);
            throw new DocumentRetrievalException("Ошибка при получении версии документа", e);
        }
    }

    public DocumentFile makeArchive(List<DocumentFile> files) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try (ZipOutputStream zos = new ZipOutputStream(baos)) {
            for (DocumentFile file : files) {
                String entryName = file.getFullName() != null ? file.getFullName() : file.getName();
                if (entryName == null) {
                    entryName = "unnamed_file_" + UUID.randomUUID();
                }
                zos.putNextEntry(new ZipEntry(entryName));
                try (InputStream is = file.getStream()) {
                    if (is != null) {
                        byte[] buffer = new byte[8192];
                        int len;
                        while ((len = is.read(buffer)) > 0) {
                            zos.write(buffer, 0, len);
                        }
                    }
                }
                zos.closeEntry();
            }
        }
        ByteArrayInputStream bais = new ByteArrayInputStream(baos.toByteArray());
        return DocumentFile.builder()
                .contentType("application/zip")
                .name("archive")
                .ext("zip")
                .stream(bais)
                .build();
    }

    private Integer resolveVersion(UUID cid, UUID did, Integer version) throws Exception {
        String basePrefix = String.format("%s/%s/", cid, did);
        Iterable<Result<Item>> results = minio.listObjects(
                ListObjectsArgs.builder()
                        .bucket(bucket)
                        .prefix(basePrefix)
                        .delimiter("/")
                        .recursive(false)
                        .build()
        );

        int maxVersion = -1;
        for (Result<Item> result : results) {
            Item item = result.get();
            if (!item.isDir()) continue;

            String[] parts = item.objectName().split("/");
            if (parts.length >= 3 && parts[0].equals(cid.toString()) && parts[1].equals(did.toString())) {
                try {
                    int v = Integer.parseInt(parts[2]);
                    maxVersion = Math.max(maxVersion, v);
                } catch (NumberFormatException ignored) {
                }
            }
        }

        if (maxVersion == -1) {
            throw new FileNotFoundException("Документ не найден");
        }
        if (version == null) {
            return maxVersion;
        }
        if (version > maxVersion) {
            throw new FileNotFoundException("Запрашиваемая версия не найдена");
        }
        return version;
    }

    private String extractExtension(String filename) {
        if (filename == null) return "";
        int dotIndex = filename.lastIndexOf('.');
        if (dotIndex == -1 || dotIndex == filename.length() - 1) return "";
        return filename.substring(dotIndex + 1);
    }

    private String extractFilename(String filename) {
        if (filename == null) return "";
        int dotIndex = filename.lastIndexOf('.');
        if (dotIndex == -1) return filename;
        return filename.substring(0, dotIndex);
    }

    private String calculateHash(InputStream inputStream) throws IOException {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] bytesBuffer = new byte[1024];
            int bytesRead = -1;
            while ((bytesRead = inputStream.read(bytesBuffer)) != -1) {
                digest.update(bytesBuffer, 0, bytesRead);
            }
            byte[] hashedBytes = digest.digest();

            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException ex) {
            throw new RuntimeException("Не удалось вычислить хеш", ex);
        } finally {
            inputStream.close();
        }
    }


    @Transactional
    public Object addDocumentVersion(UUID pid, UUID did, UUID uid, MultipartFile file) throws Exception {
        String hash = calculateHash(file.getInputStream());
        if (did == null) {
            Optional<DocumentVersion> existingDoc = documentVersionRepository.findByPidAndHash(pid, hash);
            if (existingDoc.isPresent()) {
                did = existingDoc.get().getDid();
                return "Документ с таким содержимым уже существует, did=" + did;
            }
            did = createNewDocument(pid, uid, file.getOriginalFilename());
            createNewVersion(pid, did, uid, file, hash, 1);
            return "Создан новый документ и версия 1, did=" + did;
        } else {
            boolean versionExists = documentVersionRepository.existsByPidAndDidAndHash(pid, did, hash);
            if (versionExists) {
                return "Такая версия уже существует, ничего не делаем";
            }
            int newVersion = resolveVersion(pid, did, null) + 1;
            createNewVersion(pid, did, uid, file, hash, newVersion);
            return "Создана новая версия " + newVersion;
        }
    }

    private UUID createNewDocument(UUID pid, UUID uid, String name) {
        Document doc = new Document();
        doc.setPid(pid);
        doc.setDid(UUID.randomUUID());
        doc.setUid(uid);
        doc.setSlug(generateSlug(name, this::isSlugUnique));
        doc.setCreated(Instant.now());
        doc.setModified(Instant.now());
        documentRepository.save(doc);
        return doc.getDid();
    }

    private void createNewVersion(UUID pid, UUID did, UUID uid, MultipartFile file, String hash, int version) throws Exception {
        String objectPath = String.format("%s/%s/%d/content", pid, did, version);
        minio.putObject(
                PutObjectArgs.builder()
                        .bucket(bucket)
                        .object(objectPath)
                        .stream(file.getInputStream(), file.getSize(), -1)
                        .contentType(file.getContentType())
                        .build()
        );
        DocumentVersion dv = new DocumentVersion();
        dv.setPid(pid);
        dv.setDid(did);
        dv.setVer(version);
        dv.setFilename(extractFilename(file.getOriginalFilename())
        );
        dv.setContentType(file.getContentType());
        dv.setUid(uid);
        dv.setExt(extractExtension(file.getOriginalFilename()));
        dv.setHash(hash);
        dv.setSize(file.getSize());
        dv.setCreated(Instant.now());
        documentVersionRepository.save(dv);
    }

    public String generateSlug(String input, Function<String, Boolean> isUniqueSlug) {
        String base = Normalizer.normalize(input, Normalizer.Form.NFD)
                .replaceAll("[\\p{InCombiningDiacriticalMarks}]", "") // убрать акценты
                .toLowerCase(Locale.ROOT)
                .replaceAll("[^a-z0-9]+", "-")  // заменить всё, кроме букв и цифр, на "-"
                .replaceAll("-{2,}", "-")       // убрать повторяющиеся "-"
                .replaceAll("^-|-$", "");       // убрать "-" в начале и конце
        String slug = base;
        int suffix = 1;
        while (!isUniqueSlug.apply(slug)) {
            slug = base + "-" + suffix++;
        }
        return slug;
    }

    public boolean isSlugUnique(String slug) {
        return !documentRepository.existsBySlug(slug);
    }


}