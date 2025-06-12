package ru.mirea.designvault.storage.repository;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import ru.mirea.designvault.storage.dto.DocumentChunkProjection;
import ru.mirea.designvault.storage.key.DocumentChunkId;
import ru.mirea.designvault.storage.model.DocumentChunk;

import java.util.List;
import java.util.UUID;

public interface DocumentChunkRepository extends CrudRepository<DocumentChunk, DocumentChunkId> {
    @Query(nativeQuery = true,
            value = "SELECT pid, did, content, embedding <-> cast(? as vector) AS distance FROM document_chunk ORDER BY distance LIMIT 3")
    List<DocumentChunkProjection> findNearestNeighbors(String vector);
}
