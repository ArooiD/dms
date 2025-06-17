// repo/DocumentMetaRepository.java
package ru.mirea.designvault.search.repository;

import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;
import ru.mirea.designvault.search.key.DocumentTagId;
import ru.mirea.designvault.search.model.DocumentVersionTag;

@Repository
public interface DocumentTagRepository extends JpaRepository<DocumentVersionTag, DocumentTagId> {
}