package ru.mirea.designvault.gateway.controller;

import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;

@RestController
@Tag(name = "Project API", description = "Работа с cущностью проекта")
@RequestMapping("projects/{pr_slug}/search")
public class ProjectSearchController {

}
