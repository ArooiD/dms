package ru.mirea.designvault.gateway.controller;

import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;

@RestController
@Tag(name = "Project API", description = "Работа с cущностью проекта")
@RequestMapping("projects/{pr_slug}/versions")
public class ProjectVersionController {
    @GetMapping(value = "/{doc_slug}")
    public Object getDocumentsVersions(@PathVariable("pr_slug") String pr_slug,
                                       @PathVariable("doc_slug") String doc_slug) {
        return new ArrayList<>();
    }
}
