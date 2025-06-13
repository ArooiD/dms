package ru.mirea.designvault.storage.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.mirea.designvault.storage.key.DocumentId;
import ru.mirea.designvault.storage.model.Document;

import java.util.List;
import java.util.UUID;

@Repository
public interface DocumentRepository extends CrudRepository<Document, DocumentId> {
    List<Document> getDocumentsByPid(UUID pid);

    boolean existsBySlug(String slug);
}
