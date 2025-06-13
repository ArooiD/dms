package ru.mirea.designvault.gateway.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ru.mirea.designvault.gateway.service.ProjectService;
import ru.mirea.designvault.gateway.service.StorageService;

import java.util.ArrayList;

@RestController
@Tag(name = "Project API", description = "Работа с cущностью проекта")
@RequestMapping("projects/{pr_slug}/versions")
public class ProjectVersionController {
    private final StorageService storageService;

    public ProjectVersionController(StorageService storageService) {
        this.storageService = storageService;
    }

    @Operation(
            summary = "Получить версии документа",
            description = "Возвращает список всех версий указанного документа в проекте по его slug.",
            parameters = {
                    @Parameter(name = "pr_slug", description = "Slug проекта", required = true, example = "my-project"),
                    @Parameter(name = "doc_slug", description = "Slug документа", required = true, example = "my-document")
            },
            responses = {
                    @ApiResponse(responseCode = "200", description = "Список версий документа успешно получен"),
                    @ApiResponse(responseCode = "404", description = "Документ или проект не найдены"),
                    @ApiResponse(responseCode = "500", description = "Внутренняя ошибка сервера")
            }
    )

    @GetMapping(value = {"/{doc_slug}", "/{doc_slug}/"})
    public Object getDocumentsVersions(@PathVariable("pr_slug") String pr_slug,
                                       @PathVariable("doc_slug") String doc_slug) {
        return storageService.getDocumentsVersions(pr_slug, doc_slug);
    }
}
