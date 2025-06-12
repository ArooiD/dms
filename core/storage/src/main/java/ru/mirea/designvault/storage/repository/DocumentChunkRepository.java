package ru.mirea.designvault.storage.repository;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import ru.mirea.designvault.storage.key.DocumentChunkId;
import ru.mirea.designvault.storage.model.DocumentChunk;

import java.util.List;
import java.util.UUID;

public interface DocumentChunkRepository extends CrudRepository<DocumentChunk, DocumentChunkId> {
//    @Query(value = "SELECT pid, did, cid, content, embedding <#> CAST(:vector AS vector) AS distance " +
//            "FROM document_chunk ORDER BY distance LIMIT 10", nativeQuery = true)
//    List<DocumentChunk> searchByEmbedding(@Param("vector") float[] vector);


    @Query(nativeQuery = true,
            value = "SELECT * FROM document_chunk ORDER BY embedding <-> cast(? as vector) LIMIT 3")
    List<DocumentChunk> findNearestNeighbors(float[] embedding);

}
