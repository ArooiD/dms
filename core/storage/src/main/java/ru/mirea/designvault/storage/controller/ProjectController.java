package ru.mirea.designvault.storage.controller;

import org.springframework.web.bind.annotation.*;
import ru.mirea.designvault.storage.model.Document;
import ru.mirea.designvault.storage.model.Project;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/projects") // базовый путь
public class ProjectController {
    @GetMapping("private")
    public List<Project> getPrivateProjects(@RequestParam("uid") UUID uid) {
        return new ArrayList<>();
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
