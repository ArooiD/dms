package ru.mirea.designvault.gateway.controller;

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
@RequestMapping("project")
public class ProjectController {
    private final ProjectService projectService;

    public ProjectController(ProjectService projectService) {
        this.projectService = projectService;
    }

    @GetMapping()
    public ResponseDto getAllProjects(@AuthenticationPrincipal Jwt token) {
        return projectService.getProjects(UUID.fromString(token.getSubject()));
    }

    @GetMapping("{pr_slug}/info")
    public ProjectInfoDto getProjectInfo(@AuthenticationPrincipal Jwt token, @PathVariable("pr_slug") String slug) {
        UUID uid = UUID.fromString(token.getSubject());
        return projectService.getProjectInfo(slug, uid);
    }


    @GetMapping("{pr_slug}/documents")
    public List<DocumentDto> getProjectDocuments(@AuthenticationPrincipal Jwt token, @PathVariable("pr_slug") String slug) {
        UUID uid = UUID.fromString(token.getSubject());
        return projectService.getProjectDtoDocument(slug, uid);
    }


    @PostMapping()
    public Object createProject(@AuthenticationPrincipal Jwt token, @RequestBody ProjectDto project) {
        return projectService.createProject(UUID.fromString(token.getSubject()), project);
    }

    @DeleteMapping("{pr_slug}")
    public Object deleteProject(@AuthenticationPrincipal Jwt token, @PathVariable("pr_slug") String slug, @RequestParam UUID pid) {
        return projectService.deleteProject(UUID.fromString(token.getSubject()), pid);
    }
}
