package ru.mirea.designvault.storage.model;

import jakarta.persistence.*;
import lombok.Data;
import ru.mirea.designvault.storage.converter.FloatArrayToPgVectorConverter;
import ru.mirea.designvault.storage.key.DocumentChunkId;
import ru.mirea.designvault.storage.key.DocumentId;

import java.util.UUID;

@Data
@Entity
@IdClass(DocumentChunkId.class)
@Table(schema = "public", name = "document_chunk")
public class DocumentChunk {
    @Id
    @Column(name = "pid")
    private UUID pid;
    @Id
    @Column(name = "did")
    private UUID did;
    @Id
    @Column(name = "cid", columnDefinition = "uuid default gen_random_uuid()")
    private UUID cid;
    @Column(name = "content", columnDefinition = "text")
    private String content;
    @Column(name = "embedding", columnDefinition = "vector(1536)")
    @Convert(converter = FloatArrayToPgVectorConverter.class)
    private float[] embedding;
}
