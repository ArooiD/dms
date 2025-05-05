package ru.mirea.dms.storage.controller;

import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import ru.mirea.dms.storage.dto.FileInfo;
import ru.mirea.dms.storage.service.FileService;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/file")
public class FileController {

    private final FileService fileService;

    public FileController(FileService fileService) {
        this.fileService = fileService;
    }

    @GetMapping("/")
    public List<FileInfo> list(JwtAuthenticationToken auth) throws Exception {
        UUID userId = UUID.fromString(auth.getToken().getSubject());
        return fileService.listAll(userId);
    }

    @PostMapping("/")
    public FileInfo upload(JwtAuthenticationToken auth, @RequestParam("file") MultipartFile file) throws Exception {
        UUID userId = UUID.fromString(auth.getToken().getSubject());
        return fileService.upload(userId, file);
    }

    @GetMapping("/{name}")
    public ResponseEntity<InputStreamResource> download(JwtAuthenticationToken auth, @PathVariable(name = "name") String name) throws Exception {
        UUID userId = UUID.fromString(auth.getToken().getSubject());
        InputStream is = fileService.download(userId, name);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + name + "\"")
                .body(new InputStreamResource(is));
    }

    @PutMapping("/{name}")
    public FileInfo update(JwtAuthenticationToken auth, @PathVariable(name = "name") String name, @RequestParam("file") MultipartFile file) throws Exception {
        UUID userId = UUID.fromString(auth.getToken().getSubject());
        return fileService.update(userId, name, file);
    }

    @DeleteMapping("/{name}")
    public ResponseEntity<Void> delete(JwtAuthenticationToken auth, @PathVariable(name = "name") String objectName) throws Exception {
        UUID userId = UUID.fromString(auth.getToken().getSubject());
        fileService.delete(userId, objectName);
        return ResponseEntity.noContent().build();
    }
}