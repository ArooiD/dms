package ru.mirea.designvault.storage.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Array;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.annotations.Type;
import org.hibernate.type.SqlTypes;
import ru.mirea.designvault.storage.key.DocumentChunkId;

import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
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
    @Column(name = "cid")
    private Integer cid;
    @Column(name = "content", columnDefinition = "text")
    private String content;
    @Column(name = "embedding")
    @JdbcTypeCode(SqlTypes.VECTOR)
    @Array(length = 384)
    private float[] embedding;
    @Column(
            name = "tsv",
            columnDefinition = "tsvector GENERATED ALWAYS AS (to_tsvector('russian', content)) STORED",
            insertable = false,
            updatable = false
    )
    private String tsv;
}
