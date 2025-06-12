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
    @Query(value = "SELECT pid, did, cid, content, embedding <#> CAST(:vector AS vector) AS distance " +
            "FROM document_chunk ORDER BY distance LIMIT 10", nativeQuery = true)
    List<DocumentChunk> searchByEmbedding(@Param("vector") Float[] vector);

    @Modifying
    @Query(value = "INSERT INTO document_chunk (pid, did, cid, content, embedding) VALUES (:pid, :did, :cid, :content, (:embedding)::vector(384))", nativeQuery = true)
    void insertChunk(@Param("pid") UUID pid,
                     @Param("did") UUID did,
                     @Param("cid") int cid,
                     @Param("content") String content,
                     @Param("embedding") String embedding);

}
