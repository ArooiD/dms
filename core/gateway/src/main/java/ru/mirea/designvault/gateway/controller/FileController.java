package ru.mirea.designvault.gateway.controller;

import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import ru.mirea.designvault.gateway.dto.FileDto;
import ru.mirea.designvault.gateway.model.File;
import ru.mirea.designvault.gateway.service.StorageService;

import java.util.UUID;

@RestController
@RequestMapping("project/{slug}/files")
@Tag(name = "File API", description = "Работа с файлами проекта")
public class FileController {
    private final StorageService fileService;

    public FileController(StorageService fileService) {
        this.fileService = fileService;
    }

    @GetMapping(value = {
            "{name}",
            "{name}/{ver}"
    })
    public ResponseEntity<?> fetch(@AuthenticationPrincipal Jwt token,
                                   @PathVariable("slug") String slug,
                                   @PathVariable("name") String name,
                                   @PathVariable(value = "ver", required = false) Integer ver) {
        try {
            UUID uid = UUID.fromString(token.getSubject());
            return fileService.getFileObjectVersion(slug, name, ver);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error: " + e.getMessage());
        }
    }


    @PostMapping("document")
    public ResponseEntity<?> upload(@AuthenticationPrincipal Jwt token,
                                    @PathVariable("slug") String slug,
                                    @RequestParam("file") MultipartFile file) {
        try {
            File dto = fileService.updateFileToProject(slug, file);
            return ResponseEntity.status(HttpStatus.ACCEPTED)
                    .body(dto);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error: " + e.getMessage());
        }
    }

    @PutMapping("{name}")
    public ResponseEntity<?> upload(@AuthenticationPrincipal Jwt token,
                                    @PathVariable("slug") String slug,
                                    @PathVariable("name") String name,
                                    @RequestParam("file") MultipartFile file) {
        try {
            File dto = fileService.updateFileToProject(slug, name, file);
            return ResponseEntity.status(HttpStatus.ACCEPTED).body(dto);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error: " + e.getMessage());
        }
    }

    @DeleteMapping("{name}")
    public ResponseEntity<?> deleteFileToContract(
            @AuthenticationPrincipal Jwt token,
            @PathVariable("slug") String slug,
            @PathVariable("name") String name
    ) {
        try {
            FileDto dto = fileService.deleteFileToProject(slug, name);
            return ResponseEntity.status(HttpStatus.ACCEPTED).body(dto);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error: " + e.getMessage());
        }
    }


}
