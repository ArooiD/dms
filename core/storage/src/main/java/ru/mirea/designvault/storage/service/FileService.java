package ru.mirea.designvault.storage.service;

import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import ru.mirea.designvault.storage.dto.FileInfo;
import io.minio.*;
import io.minio.messages.Item;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import ru.mirea.designvault.storage.model.File;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.time.Instant;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;


@Slf4j
@Service
public class FileService {
    private final MinioClient minio;
    private final String bucket;

    public FileService(MinioClient minio,
                       @Value("${minio.bucket}") String bucket) throws Exception {
        this.minio = minio;
        this.bucket = bucket;
        boolean exists = minio.bucketExists(BucketExistsArgs.builder().bucket(bucket).build());
        if (!exists) {
            minio.makeBucket(MakeBucketArgs.builder().bucket(bucket).build());
        }
    }

    public FileInfo upload(UUID userId, MultipartFile file) throws Exception {
        String originalFileName = file.getOriginalFilename();
        String objectName = userId + "/" + originalFileName;
        PutObjectArgs args = PutObjectArgs.builder()
                .bucket(bucket)
                .object(objectName)
                .stream(file.getInputStream(), file.getSize(), -1)
                .contentType(file.getContentType())
                .build();
        minio.putObject(args);
        StatObjectResponse stat = minio.statObject(
                StatObjectArgs.builder()
                        .bucket(bucket)
                        .object(objectName)
                        .build()
        );
        ZonedDateTime odtStat = stat.lastModified();
        Instant zdtStat = odtStat.toInstant();
        FileInfo info = new FileInfo();
        info.setObjectName(objectName);
        info.setSize(file.getSize());
        info.setContentType(file.getContentType());
        info.setLastModified(zdtStat);
        return info;
    }


    public InputStream download(UUID userId, String objectName) throws Exception {
        return minio.getObject(GetObjectArgs.builder()
                .bucket(bucket).object(userId + "/" + objectName).build());
    }

    public FileInfo update(UUID userId, String objectName, MultipartFile file) throws Exception {
        PutObjectArgs args = PutObjectArgs.builder()
                .bucket(bucket)
                .object(userId + "/" + objectName)
                .stream(file.getInputStream(), file.getSize(), -1)
                .contentType(file.getContentType())
                .build();
        minio.putObject(args);
        return upload(userId, file);
    }

    public void delete(UUID userId, String objectName) throws Exception {
        minio.removeObject(RemoveObjectArgs.builder()
                .bucket(bucket).object(userId + "/" + objectName).build());
    }

    public List<FileInfo> listAll(UUID pid) throws Exception {
        List<FileInfo> all = new ArrayList<>();
        Iterable<Result<Item>> results = minio.listObjects(
                ListObjectsArgs.builder()
                        .bucket(bucket)
                        .prefix(pid.toString() + "/")
                        .recursive(true)
                        .build()
        );
        for (Result<Item> r : results) {
            Item item = r.get();
            ZonedDateTime odtStat = item.lastModified();
            Instant instItem = odtStat.toInstant();
            FileInfo info = new FileInfo();
            info.setObjectName(item.objectName());
            info.setSize(item.size());
            info.setContentType(null);
            info.setLastModified(instItem);
            all.add(info);
        }
        return all;
    }


    public File makeArchive(List<File> files) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try (ZipOutputStream zos = new ZipOutputStream(baos)) {
            for (File file : files) {
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
        return File.builder()
                .contentType("application/zip")
                .name("archive")
                .ext("zip")
                .stream(bais)
                .build();
    }
}