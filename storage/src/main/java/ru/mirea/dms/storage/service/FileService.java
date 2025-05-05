package ru.mirea.dms.storage.service;

import ru.mirea.dms.storage.dto.FileInfo;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.List;
import java.util.UUID;

public interface FileService {
    FileInfo upload(UUID userId, MultipartFile file) throws Exception;
    InputStream download(UUID userId, String objectName) throws Exception;
    FileInfo update(UUID userId, String objectName, MultipartFile file) throws Exception;
    void delete(UUID userId, String objectName) throws Exception;
    List<FileInfo> listAll(UUID userId) throws Exception;
}