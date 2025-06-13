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
    @Column(name = "pid", nullable = false)
    private UUID pid;
    @Id
    @Column(name = "did", nullable = false, columnDefinition = "uuid default gen_random_uuid()")
    private UUID did;
    @Column(name = "uid", nullable = false)
    private UUID uid;
    @Column(name = "slug")
    private String slug;
    @Column(name = "created", nullable = false)
    private Instant created;
    @Column(name = "modified")
    private Instant modified;
}
