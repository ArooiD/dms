package ru.mirea.designvault.gateway.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.media.SchemaProperty;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import ru.mirea.designvault.gateway.dto.DocumentDto;
import ru.mirea.designvault.gateway.service.ProjectService;
import ru.mirea.designvault.gateway.service.StorageService;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("projects/{pr_slug}/documents")
@Tag(name = "Project API", description = "Работа с cущностью проекта")
public class ProjectFileController {
    private final StorageService fileService;
    private final ProjectService projectService;

    public ProjectFileController(StorageService fileService, ProjectService projectService) {
        this.fileService = fileService;
        this.projectService = projectService;
    }

    @GetMapping("")
    @Operation(
            summary = "Получить документы проекта",
            description = "Возвращает список последних версий документов по slug проекта",
            operationId = "getProjectDocuments"
    )
    public List<DocumentDto> getProjectDocuments(@AuthenticationPrincipal Jwt token, @PathVariable("pr_slug") String slug) {
        UUID uid = UUID.fromString(token.getSubject());
        return projectService.getProjectDtoDocument(slug, uid);
    }

    @Operation(
            summary = "Получение версии документа",
            description = "Возвращает файл указанной версии документа по slug проекта и slug документа. "
                    + "Если версия не указана — возвращает последнюю.",
            parameters = {
                    @Parameter(name = "pr_slug", description = "Идентификатор проекта (slug)", required = true),
                    @Parameter(name = "doc_slug", description = "Идентификатор документа (slug)", required = true),
                    @Parameter(name = "ver", description = "Номер версии документа", required = false)
            }
    )
    @GetMapping(value = {
            "{doc_slug}",
            "{doc_slug}/{ver}"
    })
    public ResponseEntity<?> fetch(
            @AuthenticationPrincipal Jwt token,
            @PathVariable("pr_slug") String slug,
            @PathVariable("doc_slug") String name,
            @PathVariable(value = "ver", required = false) Integer ver) {
        try {
//            UUID uid = UUID.fromString(token.getSubject());
            return fileService.getFileObjectVersion(slug, name, ver);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error: " + e.getMessage());
        }
    }


    @Operation(
            summary = "Загрузка нового файла версии документа",
            description = "Добавляет новую версию файла в проект по slug проекта. Файл передается в multipart/form-data.",
            parameters = {
                    @Parameter(name = "pr_slug", description = "Идентификатор проекта (slug)", required = true)
            },
            requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
                    content = @Content(
                            mediaType = "multipart/form-data",
                            schema = @Schema(implementation = MultipartFile.class)
                    )
            )
    )
    @PostMapping("new")
    public Object upload(@AuthenticationPrincipal Jwt token,
                         @PathVariable("pr_slug") String slug,
                         @RequestParam("file") MultipartFile file) {
        try {
            UUID uid = UUID.fromString(token.getSubject());
            return fileService.addFileObjectVersion(slug, uid, file);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error: " + e.getMessage());
        }
    }

    @PutMapping("{doc_slug}")
    public Object upload(@AuthenticationPrincipal Jwt token,
                         @PathVariable("pr_slug") String slug,
                         @PathVariable("doc_slug") String name,
                         @RequestParam("file") MultipartFile file) {
        try {
            UUID uid = UUID.fromString(token.getSubject());
            return fileService.addFileObjectVersion(slug, name, uid, file);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error: " + e.getMessage());
        }
    }


//    @DeleteMapping("{doc_slug}")
//    public ResponseEntity<?> deleteFileToContract(
//            @AuthenticationPrincipal Jwt token,
//            @PathVariable("pr_slug") String slug,
//            @PathVariable("doc_slug") String name
//    ) {
//        try {
//            FileDto dto = fileService.deleteFileToProject(slug, name);
//            return ResponseEntity.status(HttpStatus.ACCEPTED).body(dto);
//        } catch (Exception e) {
//            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
//                    .body("Error: " + e.getMessage());
//        }
//    }
}
