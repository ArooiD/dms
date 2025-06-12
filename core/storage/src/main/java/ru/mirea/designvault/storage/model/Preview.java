package ru.mirea.designvault.storage.model;

import jakarta.persistence.*;
import lombok.Data;
import ru.mirea.designvault.storage.key.DocumentId;
import ru.mirea.designvault.storage.key.PreviewId;
import ru.mirea.designvault.storage.key.VersionId;

import java.time.Instant;
import java.util.UUID;

@Data
@Entity
@IdClass(PreviewId.class)
@Table(schema = "public", name = "preview")
public class Preview {
    @Id
    @Column(name = "pid")
    private UUID pid;
    @Id
    @Column(name = "did")
    private UUID did;
    @Column(name = "name")
    private String name;
    @Column(name = "outext")
    private String outext;
}
