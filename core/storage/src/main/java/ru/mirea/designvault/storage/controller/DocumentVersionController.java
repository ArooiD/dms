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
import ru.mirea.designvault.storage.model.DocumentVersion;
import ru.mirea.designvault.storage.service.DocumentFileService;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.UUID;

@Slf4j
@RestController
@RequestMapping("/version/{pid}")
public class DocumentVersionController {
    private final DocumentFileService documentFileService;

    public DocumentVersionController(DocumentFileService documentFileService) {
        this.documentFileService = documentFileService;
    }

    @GetMapping(value = {
            "/{did}",
    })
    public List<DocumentVersion> getDocumentVersions(@PathVariable(value = "pid") UUID pid,
                                                    @PathVariable(value = "did") UUID did) {
        return documentFileService.getDocumentVersions(pid, did);
    }
}