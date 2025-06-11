package ru.mirea.designvault.storage.model;

import jakarta.persistence.*;
import lombok.Data;
import ru.mirea.designvault.storage.key.ProjectId;

import java.time.Instant;
import java.util.UUID;

@Data
@Entity
@IdClass(ProjectId.class)
@Table(schema = "public", name = "project")
public class Project {
    @Id
    @Column(name = "pid")
    private UUID pid;
    @Id
    @Column(name = "uid")
    private UUID uid;
    @Column(name = "slug", unique = true)
    private String slug;
    @Column(name = "name")
    private String name;
    @Column(name = "description")
    private String description;
    @Column(name = "created")
    private Instant created;
    @Column(name = "modified")
    private Instant modified;
    @Column(name = "count")
    private Integer count;
    @Column(name = "access")
    private String access;
}
