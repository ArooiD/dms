package ru.mirea.designvault.storage.controller;

import lombok.extern.slf4j.Slf4j;

import ru.mirea.designvault.storage.dto.FileInfo;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import ru.mirea.designvault.storage.model.File;
import ru.mirea.designvault.storage.service.FileService;

import java.io.InputStream;
import java.util.List;
import java.util.UUID;

@Slf4j
@RestController
@RequestMapping("/file/{pid}")
public class FileController {
    private final FileService fileService;

    public FileController(FileService fileService) {
        this.fileService = fileService;
    }

//    @PostMapping()
//    public FileInfo upload(@PathVariable(value = "pid") UUID pid, @RequestParam("file") MultipartFile file) throws Exception {
//        return fileService.upload(pid, file);
//    }

    @GetMapping(value = {
            "/{did}",
            "/{did}/",
            "/{did}/{ver}"
    })
    public ResponseEntity<InputStreamResource> getDocumentVersion(@PathVariable(value = "pid") UUID pid,
                                                                  @PathVariable(value = "did") UUID did,
                                                                  @PathVariable(value = "ver", required = false) Integer ver) {
        File object = fileService.getDocumentVersion(pid, did, ver);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + object.getName() + "\"")
                .contentType(object.getMediaType())
                .body(object.getInputStreamResource());
    }

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