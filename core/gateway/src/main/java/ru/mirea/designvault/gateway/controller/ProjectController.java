package ru.mirea.designvault.gateway.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;
import ru.mirea.designvault.gateway.dto.DocumentDto;
import ru.mirea.designvault.gateway.dto.ProjectDto;
import ru.mirea.designvault.gateway.dto.ProjectInfoDto;
import ru.mirea.designvault.gateway.dto.ResponseDto;
import ru.mirea.designvault.gateway.service.ProjectService;

import java.util.List;
import java.util.UUID;

@RestController
@Tag(name = "Project API", description = "Работа с cущностью проекта")
@RequestMapping("projects")
public class ProjectController {
    private final ProjectService projectService;

    public ProjectController(ProjectService projectService) {
        this.projectService = projectService;
    }

    @GetMapping()
    @Operation(
            summary = "Get all projects for authenticated user",
            description = "Возвращает список всех проектов, доступных текущему авторизованному пользователю",
            operationId = "getUserProjects"
    )
    public ResponseDto getAllProjects(@AuthenticationPrincipal Jwt token) {
        return projectService.getProjects(UUID.fromString(token.getSubject()));
    }

    @GetMapping("{pr_slug}/info")
    @Operation(
            summary = "Получить информацию о проекте",
            description = "Возвращает детальную информацию о проекте по его slug для текущего авторизованного пользователя",
            operationId = "getProjectInfo"
    )
    public ProjectInfoDto getProjectInfo(@AuthenticationPrincipal Jwt token, @PathVariable("pr_slug") String slug) {
        UUID uid = UUID.fromString(token.getSubject());
        return projectService.getProjectInfo(slug, uid);
    }

    @PostMapping("new")
    @Operation(
            summary = "Создать новый проект",
            description = "Создаёт новый проект от имени текущего авторизованного пользователя",
            operationId = "createProject"
    )
    public Object createProject(@AuthenticationPrincipal Jwt token, @RequestBody ProjectDto project) {
        return projectService.createProject(UUID.fromString(token.getSubject()), project);
    }

    @DeleteMapping("{pr_slug}")
    @Operation(
            summary = "Удалить проект",
            description = "Удаляет проект по slug, если текущий пользователь имеет права на удаление",
            operationId = "deleteProject"
    )
    public Object deleteProject(@AuthenticationPrincipal Jwt token, @PathVariable("pr_slug") String slug, @RequestParam UUID pid) {
        return projectService.deleteProject(UUID.fromString(token.getSubject()), pid);
    }
}
