package ru.mirea.designvault.gateway.controller;

import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import ru.mirea.designvault.gateway.dto.FileDto;
import ru.mirea.designvault.gateway.model.File;
import ru.mirea.designvault.gateway.service.FileService;

import java.util.UUID;

@Controller
@RequestMapping("project/{slug}/files")
public class FileController {
    private final FileService fileService;

    public FileController(FileService fileService) {
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
            File result = fileService.getFileObjectVersion(slug, name, ver);
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + result.getFullName() + "\"")
                    .contentType(result.getMediaType())
                    .body(result.getInputStreamResource());
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
