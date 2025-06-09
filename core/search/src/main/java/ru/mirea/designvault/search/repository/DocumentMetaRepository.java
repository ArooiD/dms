// repo/DocumentMetaRepository.java
package ru.mirea.designvault.search.repository;

import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;
import ru.mirea.designvault.search.model.DocumentMeta;
import org.springframework.data.repository.query.Param;

import java.util.List;

@Repository
public interface DocumentMetaRepository extends JpaRepository<DocumentMeta, String> {
    @Query(value = """
            SELECT * FROM document_meta
            WHERE fts @@ plainto_tsquery('russian', :q)
               OR lower(original_name) LIKE lower(concat('%',:q,'%'))
               OR lower(author) LIKE lower(concat('%',:q,'%'))
            """, nativeQuery = true)
    List<DocumentMeta> search(@Param("q") String query);
}