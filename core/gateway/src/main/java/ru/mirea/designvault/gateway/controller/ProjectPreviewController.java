package ru.mirea.designvault.gateway.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
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

    @Operation(
            summary = "Получение файла документа или его версии",
            description = "Возвращает содержимое файла документа по slug проекта, slug документа и опциональной версии.",
            parameters = {
                    @Parameter(name = "pr_slug", description = "Slug проекта", required = true),
                    @Parameter(name = "doc_slug", description = "Slug документа", required = true),
                    @Parameter(name = "ver", description = "Версия документа (необязательный параметр)", required = false)
            }
    )
    @GetMapping(value = {
            "{doc_slug}",
            "{doc_slug}/{ver}"
    })
    public ResponseEntity<?> fetch(
            @PathVariable("pr_slug") String slug,
            @PathVariable("doc_slug") String name,
            @PathVariable(value = "ver", required = false) Integer ver) {
        try {
            return storageService.getPreviewObjectVersion(slug, name, ver);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error: " + e.getMessage());
        }
    }
}
