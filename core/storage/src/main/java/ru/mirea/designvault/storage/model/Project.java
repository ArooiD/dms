package ru.mirea.designvault.storage.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

import java.time.Instant;
import java.util.UUID;

@Data
@Entity
@Table(schema = "public", name = "project")
public class Project {
    @Id
    private UUID pid;
    private UUID uid;
    private String slug;
    private String name;
    private String description;
    private Instant created;
    private Instant modified;
    private String access;
}
