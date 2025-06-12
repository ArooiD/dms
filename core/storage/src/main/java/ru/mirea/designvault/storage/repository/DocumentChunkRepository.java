package ru.mirea.designvault.storage.repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import ru.mirea.designvault.storage.key.DocumentChunkId;
import ru.mirea.designvault.storage.model.DocumentChunk;

import java.util.List;

public interface DocumentChunkRepository extends CrudRepository<DocumentChunk, DocumentChunkId> {
    @Query(value = "SELECT pid, did, cid, content, embedding <#> CAST(:vector AS vector) AS distance " +
            "FROM document_chunk ORDER BY distance LIMIT 10", nativeQuery = true)
    List<DocumentChunk> searchByEmbedding(@Param("vector") float[] vector);

}
