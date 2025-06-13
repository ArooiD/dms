package ru.mirea.designvault.storage.model;

import jakarta.persistence.*;
import lombok.Data;
import ru.mirea.designvault.storage.key.DocumentVersionId;

import java.util.UUID;

@Data
@Entity
@IdClass(DocumentVersionId.class)
@Table(schema = "public", name = "document_version_preview")
public class DocumentVersionPreview {
    @Id
    @Column(name = "pid")
    private UUID pid;
    @Id
    @Column(name = "did")
    private UUID did;
    @Id
    @Column(name = "ver")
    private Integer ver;
    @Column(name = "filename")
    private String filename;
    @Column(name = "ext")
    private String ext;
    @Column(name = "content_type")
    private String contentType;
}
