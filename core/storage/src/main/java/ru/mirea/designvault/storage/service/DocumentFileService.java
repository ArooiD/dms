package ru.mirea.designvault.storage.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import io.minio.*;
import io.minio.messages.Item;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import ru.mirea.designvault.storage.dto.DocumentVersionResponse;
import ru.mirea.designvault.storage.exception.DocumentRetrievalException;
import ru.mirea.designvault.storage.model.Document;
import ru.mirea.designvault.storage.model.DocumentFile;
import ru.mirea.designvault.storage.model.DocumentVersion;
import ru.mirea.designvault.storage.model.DocumentVersionPreview;
import ru.mirea.designvault.storage.repository.DocumentRepository;
import ru.mirea.designvault.storage.repository.DocumentVersionPreviewRepository;
import ru.mirea.designvault.storage.repository.DocumentVersionRepository;
import ru.mirea.designvault.storage.repository.projection.DocumentVersionPreviewProjection;
import ru.mirea.designvault.storage.repository.projection.DocumentVersionProjection;

import java.io.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.Normalizer;
import java.time.Instant;
import java.util.*;
import java.util.function.Function;


@Slf4j
@Service
public class DocumentFileService {
    private final MinioClient minio;
    private final String bucket;
    private final DocumentRepository documentRepository;
    private final DocumentVersionPreviewRepository documentVersionPreviewRepository;
    private final DocumentVersionRepository documentVersionRepository;
    private final RestTemplate transformClient;


    public DocumentFileService(MinioClient minio,
                               @Value("${minio.bucket}") String bucket, DocumentRepository documentRepository, DocumentVersionPreviewRepository documentVersionPreviewRepository, DocumentVersionRepository documentVersionRepository) throws Exception {
        this.minio = minio;
        this.bucket = bucket;
        this.documentRepository = documentRepository;
        this.documentVersionPreviewRepository = documentVersionPreviewRepository;
        this.documentVersionRepository = documentVersionRepository;
        this.transformClient = new RestTemplate();
        boolean exists = minio.bucketExists(BucketExistsArgs.builder().bucket(bucket).build());
        if (!exists) {
            minio.makeBucket(MakeBucketArgs.builder().bucket(bucket).build());
        }
    }

    public DocumentFile getDocumentContentVersion(UUID pid, UUID did, Integer ver) {
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
            log.info(name);
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

    public DocumentFile getDocumentPreviewVersion(UUID pid, UUID did, Integer ver) {
        try {
            Integer targetVersion = resolveVersion(pid, did, ver);
            String objectPath = String.format("%s/%s/%d/preview", pid, did, targetVersion);
            DocumentVersionPreviewProjection document = documentVersionPreviewRepository.findByPidAndDidAndVer(pid, did, targetVersion);
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
            log.info(name);
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


//    public DocumentFile makeArchive(List<DocumentFile> files) throws IOException {
//        ByteArrayOutputStream baos = new ByteArrayOutputStream();
//        try (ZipOutputStream zos = new ZipOutputStream(baos)) {
//            for (DocumentFile file : files) {
//                String entryName = file.getFullName() != null ? file.getFullName() : file.getName();
//                if (entryName == null) {
//                    entryName = "unnamed_file_" + UUID.randomUUID();
//                }
//                zos.putNextEntry(new ZipEntry(entryName));
//                try (InputStream is = file.getStream()) {
//                    if (is != null) {
//                        byte[] buffer = new byte[8192];
//                        int len;
//                        while ((len = is.read(buffer)) > 0) {
//                            zos.write(buffer, 0, len);
//                        }
//                    }
//                }
//                zos.closeEntry();
//            }
//        }
//        ByteArrayInputStream bais = new ByteArrayInputStream(baos.toByteArray());
//        return DocumentFile.builder()
//                .contentType("application/zip")
//                .name("archive")
//                .ext("zip")
//                .stream(bais)
//                .build();
//    }

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
    public DocumentVersionResponse addDocumentVersion(UUID pid, UUID did, UUID uid, MultipartFile file) throws Exception {
        String hash = calculateHash(file.getInputStream());
        if (did == null) {
            Optional<DocumentVersion> existingDoc = documentVersionRepository.findByPidAndHash(pid, hash);
            if (existingDoc.isPresent()) {
                return new DocumentVersionResponse(pid, existingDoc.get().getDid(), "Документ с таким содержимым уже существует");
            }
            did = createNewDocument(pid, uid, file.getOriginalFilename());
            createDocumentNewVersion(pid, did, uid, file, hash, 1);
            var res = generatePreview(pid, did, file);
            var contentType = Objects.requireNonNull(res.getHeaders().getContentType()).toString();
            assert res.getBody() != null;
            createPreviewNewVersion(pid, did, file.getOriginalFilename(), res.getBody(), contentType, 1);
            ocrFile(pid, did, 1, file);
            return new DocumentVersionResponse(pid, did, "Создан новый документ и версия 1");
        }
        if (documentVersionRepository.existsByPidAndDidAndHash(pid, did, hash)) {
            return new DocumentVersionResponse(pid, did, "Такая версия уже существует, ничего не делаем");
        }
        int newVersion = resolveVersion(pid, did, null) + 1;
        createDocumentNewVersion(pid, did, uid, file, hash, newVersion);
        var res = generatePreview(pid, did, file);
        var contentType = Objects.requireNonNull(res.getHeaders().getContentType()).toString();
        assert res.getBody() != null;
        createPreviewNewVersion(pid, did, file.getOriginalFilename(), res.getBody(), contentType, newVersion);
        ocrFile(pid, did, newVersion, file);
        return new DocumentVersionResponse(pid, did, "Создана новая версия " + newVersion);
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

    private void createDocumentNewVersion(UUID pid, UUID did, UUID uid, MultipartFile file, String hash, int version) throws Exception {
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
        dv.setFilename(extractFilename(file.getOriginalFilename()));
        dv.setContentType(file.getContentType());
        dv.setUid(uid);
        dv.setExt(extractExtension(file.getOriginalFilename()));
        dv.setHash(hash);
        dv.setSize(file.getSize());
        dv.setCreated(Instant.now());
        documentVersionRepository.save(dv);
    }

    private void createPreviewNewVersion(UUID pid, UUID did, String filename, String html, String contentType, int version) throws Exception {
        byte[] bytes = html.getBytes();

        InputStream inputStream = new ByteArrayInputStream(bytes);
        String objectPath = String.format("%s/%s/%d/preview", pid, did, version);
        minio.putObject(
                PutObjectArgs.builder()
                        .bucket(bucket)
                        .object(objectPath)
                        .stream(inputStream, bytes.length, -1)
                        .contentType(contentType)
                        .build()
        );
        DocumentVersionPreview dvp = new DocumentVersionPreview();
        dvp.setPid(pid);
        dvp.setDid(did);
        dvp.setVer(version);
        dvp.setFilename(extractFilename(filename));
        dvp.setContentType(contentType);
        documentVersionPreviewRepository.save(dvp);
    }


    public ResponseEntity<String> generatePreview(UUID pid, UUID did, MultipartFile file) throws Exception {
        String url = "http://core.transform:8000/generate/preview";
        ByteArrayResource fileAsResource = new ByteArrayResource(file.getBytes()) {
            @Override
            public String getFilename() {
                return file.getOriginalFilename(); // имя файла обязательно!
            }
        };
        HttpHeaders fileHeaders = new HttpHeaders();
        fileHeaders.setContentType(MediaType.parseMediaType(Objects.requireNonNull(file.getContentType())));
        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        body.add("file", new HttpEntity<>(fileAsResource, fileHeaders));
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);
        HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);
        return transformClient.postForEntity(url, requestEntity, String.class);
    }

    public String generateSlug(String input, Function<String, Boolean> isUniqueSlug) {
        String base = Normalizer.normalize(input, Normalizer.Form.NFD)
                .replaceAll("[\\p{InCombiningDiacriticalMarks}]", "")
                .toLowerCase(Locale.ROOT)
                .replaceAll("[^a-z0-9]+", "-")
                .replaceAll("-{2,}", "-")
                .replaceAll("^-|-$", "");
        String slug = base;
        int suffix = 1;
        while (!isUniqueSlug.apply(slug)) {
            slug = base + "-" + suffix++;
        }
        return slug;
    }

    public ResponseEntity<String> ocrFile(UUID pid, UUID did, Integer version, MultipartFile file) throws IOException {
        String url = "http://core.ocr:8000/analyse/upload";
        ByteArrayResource fileAsResource = new ByteArrayResource(file.getBytes()) {
            @Override
            public String getFilename() {
                return file.getOriginalFilename();
            }
        };
        HttpHeaders fileHeaders = new HttpHeaders();
        fileHeaders.setContentType(MediaType.parseMediaType(Objects.requireNonNull(file.getContentType())));
        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        body.add("pid", pid);
        body.add("ver", version);
        body.add("did", did);
        body.add("file", new HttpEntity<>(fileAsResource, fileHeaders));
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);
        HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);
        return transformClient.postForEntity(url, requestEntity, String.class);
    }


    public boolean isSlugUnique(String slug) {
        return !documentRepository.existsBySlug(slug);
    }

    public List<DocumentVersion> getDocumentVersions(UUID pid, UUID did) {
        return documentVersionRepository.findAllByPidAndDid(pid, did);
    }
}