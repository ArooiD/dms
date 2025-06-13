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
            value = """
                      WITH q AS (SELECT plainto_tsquery('russian', ?2) AS query)
                      SELECT pid, did, content,
                             embedding <-> cast(?1 AS vector) AS distance,
                             ts_rank(tsv, q.query) AS rank
                      FROM document_chunk, q
                      WHERE tsv @@ q.query
                      ORDER BY distance ASC, rank DESC
                      LIMIT ?3
                    """
    )
    List<DocumentChunkProjection> findNearestNeighborsWithFullText(String vector, String textQuery, int limit);

    @Modifying
    @Transactional
    @Query(nativeQuery = true,
            value = """
                    DELETE FROM document_chunk WHERE pid = :pid AND did = :did
                    """)
    void deleteAllByPidAndDid(UUID pid, UUID did);
}
