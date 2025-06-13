package ru.mirea.designvault.storage.controller;

import lombok.extern.slf4j.Slf4j;

import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import ru.mirea.designvault.storage.model.DocumentFile;
import ru.mirea.designvault.storage.service.DocumentFileService;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.UUID;

@Slf4j
@RestController
@RequestMapping("/file/{pid}")
public class DocumentFileController {
    private final DocumentFileService documentFileService;

    public DocumentFileController(DocumentFileService documentFileService) {
        this.documentFileService = documentFileService;
    }

    @GetMapping(value = {
            "/{did}",
            "/{did}/",
            "/{did}/{ver}"
    })
    public ResponseEntity<InputStreamResource> getDocumentVersion(@PathVariable(value = "pid") UUID pid,
                                                                  @PathVariable(value = "did") UUID did,
                                                                  @PathVariable(value = "ver", required = false) Integer ver) {
        DocumentFile object = documentFileService.getDocumentVersion(pid, did, ver);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION,
                        "attachment; filename=\"" + encodeFallbackName(object.getName()) + "\"; filename*=UTF-8''" + URLEncoder.encode(object.getName(), StandardCharsets.UTF_8))
                .contentType(object.getMediaType())
                .body(object.getInputStreamResource());
    }


    @PostMapping(
            value = {"", "/", "/{did}"},
            consumes = MediaType.MULTIPART_FORM_DATA_VALUE
    )
    public Object upload(@PathVariable("pid") UUID pid,
                         @PathVariable(value = "did", required = false) UUID did,
                         @RequestParam("uid") UUID uid,
                         @RequestPart("file") MultipartFile file) throws Exception {
        return documentFileService.addDocumentVersion(pid, did, uid, file);
    }

    private String encodeFallbackName(String name) {
        return name.replaceAll("[^\\x20-\\x7E]", "_");
    }

//        return fileService.upload(pid, file);
//    }


//    @PutMapping("{name}")
//    public FileInfo update(@PathVariable(value = "pid") UUID pid, @PathVariable(name = "name") String name, @RequestParam("file") MultipartFile file) throws Exception {
//        return fileService.update(pid, name, file);
//    }
//
//    @DeleteMapping("{name}")
//    public ResponseEntity<Void> delete(@PathVariable(value = "pid") UUID pid, @PathVariable(name = "name") String objectName) throws Exception {
//        fileService.delete(pid, objectName);
//        return ResponseEntity.noContent().build();
//    }
}