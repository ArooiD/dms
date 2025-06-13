package ru.mirea.designvault.storage.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.mirea.designvault.storage.key.DocumentVersionId;
import ru.mirea.designvault.storage.model.Document;
import ru.mirea.designvault.storage.model.DocumentVersion;
import ru.mirea.designvault.storage.repository.projection.DocumentVersionProjection;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface DocumentVersionRepository extends CrudRepository<DocumentVersion, DocumentVersionId> {
    DocumentVersionProjection findByPidAndDidAndVer(UUID pid, UUID did, Integer ver);

    Optional<DocumentVersion> findByPidAndHash(UUID pid, String hash);

    boolean existsByPidAndDidAndHash(UUID pid, UUID did, String hash);
}
