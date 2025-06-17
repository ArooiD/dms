// repo/DocumentMetaRepository.java
package ru.mirea.designvault.search.repository;

import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import ru.mirea.designvault.search.key.DocumentTagId;
import ru.mirea.designvault.search.model.DocumentVersionTag;

import java.util.List;

@Repository
public interface DocumentTagRepository extends JpaRepository<DocumentVersionTag, DocumentTagId> {
    @Query(nativeQuery = true, value = "select distinct t.pid, t.did, t.ver from document_version_tag t where t.name in :tags")
    List<DocumentTagId> findIdByTag(@Param("tags") List<String> tags);
}