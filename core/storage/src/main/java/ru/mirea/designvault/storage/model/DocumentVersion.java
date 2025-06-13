package ru.mirea.designvault.storage.model;

import jakarta.persistence.*;
import lombok.Data;
import ru.mirea.designvault.storage.key.VersionId;

import java.time.Instant;
import java.util.UUID;

@Data
@Entity
@IdClass(VersionId.class)
@Table(schema = "public", name = "document_version")
public class DocumentVersion {
    @Id
    @Column(name = "pid", nullable = false)
    private UUID pid;
    @Id
    @Column(name = "did", nullable = false)
    private UUID did;
    @Id
    @Column(name = "ver", nullable = false)
    private Integer ver;
    @Column(name = "uid", nullable = false)
    private UUID uid;
    @Column(name = "filename", nullable = false)
    private String filename;
    @Column(name = "ext", nullable = false)
    private String ext;
    @Column(name = "content_type", nullable = false)
    private String contentType;
    @Column(name = "hash", nullable = false)
    private String hash;
    @Column(name = "size", nullable = false)
    private Long size;
    @Column(name = "created", nullable = false)
    private Instant created;
}
