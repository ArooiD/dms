package ru.mirea.dms.search.service;

import org.springframework.stereotype.Service;
import ru.mirea.dms.search.repository.DocumentMetaRepository;
import ru.mirea.dms.search.model.DocumentMeta;

import java.util.List;

@Service
public class SearchService {
    private final DocumentMetaRepository repository;

    public SearchService(DocumentMetaRepository repo) {
        this.repository = repo;
    }

    public DocumentMeta save(DocumentMeta m) {
        return repository.save(m);
    }

    public List<DocumentMeta> search(String q) {
        return repository.search(q);
    }
}