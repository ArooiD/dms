package ru.mirea.designvault.gateway.service;

import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import ru.mirea.designvault.gateway.dto.DocumentVersionDto;
import ru.mirea.designvault.gateway.dto.DocumentVersionResponse;

import java.io.IOException;
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

    public UUID resolveDocumentSlug(UUID pid, String documentSlug) {
        ResponseEntity<UUID> response = client.getForEntity("/projects/" + pid + "/documents/" + documentSlug + "/did", UUID.class);
        UUID result = response.getBody();
        if (result == null) {
            throw new RuntimeException("Document UUID not found for slug: " + documentSlug);
        }
        return result;
    }

    public String resolveDocumentSlug(UUID pid, UUID did) {
        ResponseEntity<String> response = client.getForEntity("/projects/" + pid + "/documents/" + did + "/slug", String.class);
        String result = response.getBody();
        if (result == null) {
            throw new RuntimeException("Document UUID not found for did: " + did);
        }
        return result;
    }


    public ResponseEntity<Resource> getFileObjectVersion(String slug, String name, Integer ver) {
        UUID pid = resolveProjectSlug(slug);
        UUID did = resolveDocumentSlug(pid, name);
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
        UUID pid = resolveProjectSlug(slug);
        UUID did = resolveDocumentSlug(pid, name);
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

    public DocumentVersionDto addFileObjectVersion(String slug, UUID uid, MultipartFile file) throws IOException {
        UUID pid = resolveProjectSlug(slug);
        String url = "/file/" + pid + "/";
        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        ByteArrayResource fileAsResource = new ByteArrayResource(file.getBytes()) {
            @Override
            public String getFilename() {
                return file.getOriginalFilename();
            }
        };
        body.add("file", fileAsResource);
        body.add("uid", uid.toString());
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);
        HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);
        ResponseEntity<DocumentVersionResponse> response = client.postForEntity(url, requestEntity, DocumentVersionResponse.class);
        var e = response.getBody();
        return new DocumentVersionDto(slug, resolveDocumentSlug(e.getPid(), e.getDid()), e.getStatus());
    }

    public DocumentVersionDto addFileObjectVersion(String slug, String name, UUID uid, MultipartFile file) throws IOException {
        UUID pid = resolveProjectSlug(slug);
        UUID did = resolveDocumentSlug(pid, name);
        String url = "/file/" + pid + "/" + did;
        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        ByteArrayResource fileAsResource = new ByteArrayResource(file.getBytes()) {
            @Override
            public String getFilename() {
                return file.getOriginalFilename();
            }
        };
        body.add("file", fileAsResource);
        body.add("uid", uid.toString());
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);
        HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);
        ResponseEntity<DocumentVersionResponse> response = client.postForEntity(url, requestEntity, DocumentVersionResponse.class);
        var e = response.getBody();
        return new DocumentVersionDto(slug, name, e.getStatus());
    }
}
