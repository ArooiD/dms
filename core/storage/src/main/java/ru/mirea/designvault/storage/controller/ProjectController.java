package ru.mirea.designvault.storage.controller;

import org.springframework.web.bind.annotation.*;
import ru.mirea.designvault.storage.dto.ProjectDto;
import ru.mirea.designvault.storage.model.Document;
import ru.mirea.designvault.storage.model.Project;
import ru.mirea.designvault.storage.service.ProjectService;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/projects") // базовый путь
public class ProjectController {
    private final ProjectService projectService;

    public ProjectController(ProjectService projectService) {
        this.projectService = projectService;
    }

    @GetMapping("private")
    public List<Project> getPrivateProjects(@RequestParam("uid") UUID uid) {
        return projectService.getAllProjects(uid);
    }

    @GetMapping("{pid}")
    public Project getProject(@PathVariable("pid") UUID pid, @RequestParam("uid") UUID uid) {
        return projectService.getProject(pid, uid);
    }

    @GetMapping("/{slug}/pid")
    public UUID getProject(@PathVariable("slug") String slug) {
        return projectService.resolvePid(slug);
    }

    @GetMapping("/{pid}/documents/{slug}/did")
    public UUID getProjectDocument(
            @PathVariable("pid") UUID pid,
            @PathVariable("slug") String slug) {
        return projectService.resolveDid(pid, slug);
    }

    @PostMapping()
    public Object createProject(@RequestParam("uid") UUID uid, @RequestBody ProjectDto dto) {
        return projectService.createProject(uid, dto);
    }

    @DeleteMapping
    public Object deleteProject(@RequestParam("uid") UUID uid, @RequestParam("pid") UUID pid) {
        return projectService.deleteProject(uid, pid);
    }

    @GetMapping("shared")
    public List<Project> getSharedProjects(@RequestParam("uid") UUID uid) {
        return new ArrayList<>();
    }

    @GetMapping("{slug}/documents")
    public List<Document> getProjectDocument(@PathVariable("slug") String slug) {
        return projectService.getProjectDocument(slug);
    }


}
