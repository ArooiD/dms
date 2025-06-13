package ru.mirea.designvault.storage.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ru.mirea.designvault.storage.model.DocumentFile;
import ru.mirea.designvault.storage.service.DocumentFileService;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.UUID;

@Slf4j
@RestController
@RequestMapping("/version/{pid}")
public class DocumentVersionController {
    private final DocumentFileService documentFileService;

    public DocumentVersionController(DocumentFileService documentFileService) {
        this.documentFileService = documentFileService;
    }

//    @GetMapping(value = {
//            "/{did}",
//    })
//    public ResponseEntity<InputStreamResource> getDocumentVersion(@PathVariable(value = "pid") UUID pid,
//                                                                  @PathVariable(value = "did") UUID did) {
//        DocumentFile object = documentFileService.getDocumentPreviewVersion(pid, did, ver);
//        return ResponseEntity.ok()
//                .header(HttpHeaders.CONTENT_DISPOSITION,
//                        "attachment; filename=\"" + encodeFallbackName(object.getName()) + "\"; filename*=UTF-8''" + URLEncoder.encode(object.getName(), StandardCharsets.UTF_8))
//                .contentType(object.getMediaType())
//                .body(object.getInputStreamResource());
//    }
}