package ru.mirea.designvault.storage.repository;

import org.springframework.data.repository.CrudRepository;
import ru.mirea.designvault.storage.key.DocumentChunkId;
import ru.mirea.designvault.storage.model.DocumentChunk;

public interface DocumentChunkRepository extends CrudRepository<DocumentChunk, DocumentChunkId> {
}
