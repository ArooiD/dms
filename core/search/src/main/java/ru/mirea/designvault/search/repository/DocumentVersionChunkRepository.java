package ru.mirea.designvault.search.repository;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.transaction.annotation.Transactional;
import ru.mirea.designvault.search.key.DocumentChunkId;
import ru.mirea.designvault.search.model.DocumentVersionChunk;
import ru.mirea.designvault.search.repository.projection.DocumentVersionChunkProjection;
import ru.mirea.designvault.search.model.DocumentVersionChunk;
import ru.mirea.designvault.search.repository.projection.DocumentVersionChunkProjection;

import java.util.List;
import java.util.UUID;

public interface DocumentVersionChunkRepository extends CrudRepository<DocumentVersionChunk, DocumentChunkId> {
    @Query(nativeQuery = true,
            value = """
                      WITH q AS (SELECT plainto_tsquery('russian', ?2) AS query)
                      SELECT pid, did, content,
                             embedding <-> cast(?1 AS vector) AS distance,
                             ts_rank(tsv, q.query) AS rank
                      FROM document_version_chunk, q
                      WHERE tsv @@ q.query
                      ORDER BY distance ASC, rank DESC
                      LIMIT ?3
                    """
    )
    List<DocumentVersionChunkProjection> findNearestNeighborsWithFullText(String vector, String textQuery, int limit);

    @Modifying
    @Transactional
    @Query(nativeQuery = true,
            value = """
                    DELETE FROM document_version_chunk WHERE pid = :pid AND did = :did
                    """)
    void deleteAllByPidAndDid(UUID pid, UUID did);
}
