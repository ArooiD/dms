package ru.mirea.designvault.storage.model;

import jakarta.persistence.*;
import lombok.Data;
import ru.mirea.designvault.storage.key.DocumentId;

import java.time.Instant;
import java.util.UUID;

@Data
@Entity
@IdClass(DocumentId.class)
@Table(schema = "public", name = "document")
public class Document {
    @Id
    @Column(name = "pid")
    private UUID pid;
    @Id
    @Column(name = "uid")
    private UUID uid;
    @Id
    @Column(name = "did")
    private UUID did;
    @Column(name = "slug", unique = true)
    private String slug;
    @Column(name = "filename")
    private String filename;
    @Column(name = "ext")
    private String ext;
    @Column(name = "version")
    private Integer version;
    @Column(name = "created")
    private Instant created;
    @Column(name = "modified")
    private Instant modified;
}
