package ru.mirea.designvault.storage.controller;

import lombok.extern.slf4j.Slf4j;

import ru.mirea.designvault.storage.dto.FileInfo;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import ru.mirea.designvault.storage.service.FileService;

import java.io.InputStream;
import java.util.List;
import java.util.UUID;

@Slf4j
@RestController
@RequestMapping("/file")
public class FileController {
    private final FileService fileService;

    public FileController(FileService fileService) {
        this.fileService = fileService;
    }

    @GetMapping(value = "{pid}")
    public List<FileInfo> list(@PathVariable(value = "pid") UUID pid) throws Exception {
        return fileService.listAll(pid);
    }

    @PostMapping(value = "{pid}")
    public FileInfo upload(@PathVariable(value = "pid") UUID pid, @RequestParam("file") MultipartFile file) throws Exception {
        return fileService.upload(pid, file);
    }

    @GetMapping("{pid}/{name}")
    public ResponseEntity<InputStreamResource> download(@PathVariable(value = "pid") UUID pid, @PathVariable(name = "name") String name) throws Exception {
        InputStream is = fileService.download(pid, name);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + name + "\"")
                .body(new InputStreamResource(is));
    }

    @PutMapping("{pid}/{name}")
    public FileInfo update(@PathVariable(value = "pid") UUID pid, @PathVariable(name = "name") String name, @RequestParam("file") MultipartFile file) throws Exception {
        return fileService.update(pid, name, file);
    }

    @DeleteMapping("{pid}/{name}")
    public ResponseEntity<Void> delete(@PathVariable(value = "pid") UUID pid, @PathVariable(name = "name") String objectName) throws Exception {
        fileService.delete(pid, objectName);
        return ResponseEntity.noContent().build();
    }
}