package ru.mirea.designvault.storage.controller;

import lombok.extern.slf4j.Slf4j;

import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ru.mirea.designvault.storage.model.DocumentFile;
import ru.mirea.designvault.storage.service.DocumentFileService;

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
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + object.getName() + "\"")
                .contentType(object.getMediaType())
                .body(object.getInputStreamResource());
    }




    //    @PostMapping()
//    public FileInfo upload(@PathVariable(value = "pid") UUID pid, @RequestParam("file") MultipartFile file) throws Exception {
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