package ru.mirea.designvault.storage.repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import ru.mirea.designvault.storage.key.DocumentId;
import ru.mirea.designvault.storage.model.Document;
import ru.mirea.designvault.storage.repository.projection.DocumentInfoDto;

import java.util.List;
import java.util.UUID;

@Repository
public interface DocumentRepository extends CrudRepository<Document, DocumentId> {
    @Query(value = """
            SELECT d.pid, d.did, d.uid, d.slug, v.ver, v.filename, v.ext, d.created AS created, v.created AS modified
            FROM document d
            JOIN document_version v ON d.did = v.did
            WHERE d.pid = :pid
              AND v.ver = (
                SELECT MAX(v2.ver)
                FROM document_version v2
                WHERE v2.did = d.did
              )
            """, nativeQuery = true)
    List<DocumentInfoDto> getDocumentsByPid(@Param("pid") UUID pid);

    boolean existsBySlug(String slug);

    Document findDocumentsByPidAndSlug(UUID pid, String slug);

    Document findDocumentsByPidAndDid(UUID pid, UUID did);


}
