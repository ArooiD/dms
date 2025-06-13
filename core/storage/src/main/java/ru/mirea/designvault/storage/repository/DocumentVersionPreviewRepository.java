package ru.mirea.designvault.storage.repository;

import org.springframework.data.repository.CrudRepository;
import ru.mirea.designvault.storage.key.DocumentVersionId;
import ru.mirea.designvault.storage.model.DocumentVersionPreview;
import ru.mirea.designvault.storage.repository.projection.DocumentVersionPreviewProjection;

import java.util.UUID;

public interface DocumentVersionPreviewRepository extends CrudRepository<DocumentVersionPreview, DocumentVersionId> {

    DocumentVersionPreviewProjection findByPidAndDidAndVer(UUID pid, UUID did, Integer targetVersion);
}
