package ru.mirea.designvault.search.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Array;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;
import ru.mirea.designvault.search.key.DocumentChunkId;

import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@IdClass(DocumentChunkId.class)
@Table(schema = "public", name = "document_version_chunk")
public class DocumentVersionChunk {
    @Id
    @Column(name = "pid")
    @JdbcTypeCode(SqlTypes.UUID)
    private UUID pid;
    @Id
    @Column(name = "did")
    @JdbcTypeCode(SqlTypes.UUID)
    private UUID did;
    @Id
    @Column(name = "ver")
    @JdbcTypeCode(SqlTypes.INTEGER)
    private Integer ver;
    @Id
    @Column(name = "cid")
    @JdbcTypeCode(SqlTypes.INTEGER)
    private int cid;
    @Column(name = "content", columnDefinition = "text")
    @JdbcTypeCode(SqlTypes.LONGNVARCHAR)
    private String content;
    @Column(
            name = "tsv",
            columnDefinition = "tsvector GENERATED ALWAYS AS (to_tsvector('russian', content)) STORED",
            insertable = false,
            updatable = false
    )
    @JdbcTypeCode(SqlTypes.OTHER)
    private String tsv;
}
