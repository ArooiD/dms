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

    @GetMapping("/{pid}/documents")
    public List<Document> getProjectDocument(
            @PathVariable("pid") UUID pid
    ) {
        return new ArrayList<>();
    }

    @GetMapping("/{pid}/documents/{did}")
    public Document getProjectDocument(
            @PathVariable("pid") UUID pid,
            @PathVariable("did") UUID did
    ) {

        return new Document();
    }
}
