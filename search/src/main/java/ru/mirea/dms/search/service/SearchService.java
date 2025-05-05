package ru.mirea.dms.search.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import ru.mirea.dms.search.repository.DocumentMetaRepository;
import ru.mirea.dms.search.model.DocumentMeta;

import java.util.List;

@Service
public class SearchService {
    private final Logger logger;
    private final DocumentMetaRepository repository;

    public SearchService(DocumentMetaRepository repository) {
        this.logger = LoggerFactory.getLogger(this.getClass());
        this.repository = repository;
    }

    public DocumentMeta save(DocumentMeta m) {
        return repository.save(m);
    }

    public List<DocumentMeta> search(String q) {
        return repository.search(q);
    }
}