package ru.mirea.designvault.gateway.controller;

import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ru.mirea.designvault.gateway.service.StorageService;

@RestController
@Tag(name = "Project API", description = "Работа с cущностью проекта")
@RequestMapping("projects/{pr_slug}/preview")
public class ProjectPreviewController {

    private final StorageService storageService;

    public ProjectPreviewController(StorageService storageService) {
        this.storageService = storageService;
    }

    @GetMapping(value = {
            "{doc_slug}",
            "{doc_slug}/{ver}"
    })
    public ResponseEntity<?> fetch(
//            @AuthenticationPrincipal Jwt token,
            @PathVariable("pr_slug") String slug,
            @PathVariable("doc_slug") String name,
            @PathVariable(value = "ver", required = false) Integer ver) {
        try {
//            UUID uid = UUID.fromString(token.getSubject());
            return storageService.getFileObjectVersion(slug, name, ver);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error: " + e.getMessage());
        }
    }
}
