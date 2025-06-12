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
    @Column(name = "did", columnDefinition = "uuid default gen_random_uuid()")
    private UUID did;
    @Column(name = "uid")
    private UUID uid;
    @Column(name = "slug")
    private String slug;
    @Column(name = "filename")
    private String filename;
    @Column(name = "ext")
    private String ext;
    @Column(name = "created")
    private Instant created;
    @Column(name = "modified")
    private Instant modified;
    @Column(name = "hash")
    private String hash;
    @Column(name = "size")
    private Long size;
}
