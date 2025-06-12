package ru.mirea.designvault.storage.model;

import jakarta.persistence.*;
import lombok.Data;
import ru.mirea.designvault.storage.key.DocumentId;

import java.util.UUID;

@Data
@Entity
@IdClass(DocumentId.class)
@Table(schema = "public", name = "document_preview")
public class DocumentPreview {
    @Id
    @Column(name = "pid")
    private UUID pid;
    @Id
    @Column(name = "did")
    private UUID did;
    @Column(name = "name")
    private String name;
    @Column(name = "out_ext")
    private String outExt;
}
