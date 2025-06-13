package ru.mirea.designvault.gateway.service;

import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.core.io.Resource;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;

@Service
public class StorageService {
    private final RestTemplate client;

    public StorageService(RestTemplateBuilder builder) {
        this.client = builder
                .rootUri("http://core.storage:8000")
                .build();
    }

    public UUID resolveProjectSlug(String projectSlug) {
        ResponseEntity<UUID> response = client.getForEntity("/projects/" + projectSlug + "/pid", UUID.class);
        UUID result = response.getBody();
        if (result == null) {
            throw new RuntimeException("Project UUID not found for slug: " + projectSlug);
        }
        return result;
    }

    public UUID resolveDocumentSlug(String documentSlug) {
        ResponseEntity<UUID> response = client.getForEntity("/documents/" + documentSlug + "/did", UUID.class);
        UUID result = response.getBody();
        if (result == null) {
            throw new RuntimeException("Document UUID not found for slug: " + documentSlug);
        }
        return result;
    }

    public ResponseEntity<Resource> getFileObjectVersion(String slug, String name, Integer ver) {
        UUID pid = UUID.fromString("84055427-00ea-41e0-800a-e3e31f8acefc");
        UUID did = UUID.fromString("1eef8b77-0e78-4f34-b45c-95d3017b4239");
        String url;
        Object[] uriVariables;
        if (ver == null) {
            url = "/file/{pid}/{did}";
            uriVariables = new Object[]{pid, did};
        } else {
            url = "/file/{pid}/{did}/{ver}";
            uriVariables = new Object[]{pid, did, ver};
        }
        ResponseEntity<Resource> response = client.exchange(
                url,
                HttpMethod.GET,
                HttpEntity.EMPTY,
                Resource.class,
                uriVariables
        );
        if (!response.getStatusCode().is2xxSuccessful()) {
            throw new RuntimeException("Ошибка при получении файла: " + response.getStatusCode());
        }
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(response.getHeaders().getContentType());
        String contentDisposition = response.getHeaders().getFirst(HttpHeaders.CONTENT_DISPOSITION);
        if (contentDisposition != null) {
            headers.set(HttpHeaders.CONTENT_DISPOSITION, contentDisposition);
        }
        return new ResponseEntity<>(response.getBody(), headers, HttpStatus.OK);
    }

    public ResponseEntity<Resource> getPreviewObjectVersion(String slug, String name, Integer ver) {
        UUID pid = UUID.fromString("84055427-00ea-41e0-800a-e3e31f8acefc");
        UUID did = UUID.fromString("1eef8b77-0e78-4f34-b45c-95d3017b4239");
        String url;
        Object[] uriVariables;
        if (ver == null) {
            url = "/preview/{pid}/{did}";
            uriVariables = new Object[]{pid, did};
        } else {
            url = "/preview/{pid}/{did}/{ver}";
            uriVariables = new Object[]{pid, did, ver};
        }
        ResponseEntity<Resource> response = client.exchange(
                url,
                HttpMethod.GET,
                HttpEntity.EMPTY,
                Resource.class,
                uriVariables
        );
        if (!response.getStatusCode().is2xxSuccessful()) {
            throw new RuntimeException("Ошибка при получении файла: " + response.getStatusCode());
        }
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(response.getHeaders().getContentType());
        String contentDisposition = response.getHeaders().getFirst(HttpHeaders.CONTENT_DISPOSITION);
        if (contentDisposition != null) {
            headers.set(HttpHeaders.CONTENT_DISPOSITION, contentDisposition);
        }
        return new ResponseEntity<>(response.getBody(), headers, HttpStatus.OK);
    }

    public Object addFileObjectVersion(String slug, UUID uid, MultipartFile file) {

        return null;
    }

    public Object addFileObjectVersion(String slug, String name, UUID uid, MultipartFile file) {
        return null;
    }
}
