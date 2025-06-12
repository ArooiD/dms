package ru.mirea.designvault.gateway.service;

import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import ru.mirea.designvault.gateway.dto.FileDto;
import ru.mirea.designvault.gateway.model.File;

@Service
public class FileService {
    private final RestTemplate restTemplate;

    public FileService(RestTemplateBuilder builder) {
        this.restTemplate = builder
                .rootUri("http://core.storage:8000")
                .build();
    }

    public File getFileObjectVersion(String slug, String name, Integer ver) {
        return null;
    }

    public File updateFileToProject(String slug, String name, MultipartFile file) {
        return null;
    }

    public File updateFileToProject(String slug, MultipartFile file) {
        return null;
    }

    public FileDto deleteFileToProject(String slug, String name) {
        return null;
    }
}
