package ru.mirea.designvault.storage.model;

import jakarta.persistence.*;
import lombok.Data;
import ru.mirea.designvault.storage.key.DocumentId;
import ru.mirea.designvault.storage.key.VersionId;

import java.time.Instant;
import java.util.UUID;

@Data
@Entity
@IdClass(VersionId.class)
@Table(schema = "public", name = "version")
public class Version {
    @Id
    @Column(name = "pid")
    private UUID pid;
    @Id
    @Column(name = "did")
    private UUID did;
    @Id
    @Column(name = "ver")
    private Integer ver;
    @Column(name = "uid")
    private UUID uid;
    @Column(name = "hash")
    private String hash;
    @Column(name = "size")
    private Long size;
    @Column(name = "filepath")
    private String filepath;
    @Column(name = "created")
    private Instant created;
}
