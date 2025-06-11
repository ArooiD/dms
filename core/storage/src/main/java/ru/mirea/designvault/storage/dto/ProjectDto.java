package ru.mirea.designvault.storage.dto;

import lombok.Data;

@Data
public class ProjectDto {
    private String slug;
    private String name;
    private String description;
    private String access;
}
