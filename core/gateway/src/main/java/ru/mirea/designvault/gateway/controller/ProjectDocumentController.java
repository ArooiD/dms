package ru.mirea.designvault.gateway.controller;

import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ru.mirea.designvault.gateway.dto.DocumentDto;
import ru.mirea.designvault.gateway.service.ProjectService;

import java.util.List;
import java.util.UUID;

@RestController
@Tag(name = "Project API", description = "Работа с cущностью проекта")
@RequestMapping("projects/{pr_slug}/documents")
public class ProjectDocumentController {

    private final ProjectService projectService;

    public ProjectDocumentController(ProjectService projectService) {
        this.projectService = projectService;
    }

    @GetMapping("")
    public List<DocumentDto> getProjectDocuments(@AuthenticationPrincipal Jwt token, @PathVariable("pr_slug") String slug) {
        UUID uid = UUID.fromString(token.getSubject());
        return projectService.getProjectDtoDocument(slug, uid);
    }
}
