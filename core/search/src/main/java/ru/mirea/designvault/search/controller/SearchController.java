// controller/SearchController.java
package ru.mirea.designvault.search.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;
import ru.mirea.designvault.search.model.DocumentMeta;
import ru.mirea.designvault.search.service.SearchService;

import java.util.List;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/search")
public class SearchController {
    private final SearchService searchService;
    private final Logger logger;

    public SearchController(SearchService searchService) {
        this.searchService = searchService;
        this.logger = LoggerFactory.getLogger(this.getClass());
    }

    @PostMapping("/metadata")
    public DocumentMeta upsert(@RequestBody DocumentMeta meta) {
        return searchService.save(meta);
    }

    @GetMapping
    public List<DocumentMeta> query(@RequestParam("q") String q) {
        return searchService.search(q);
    }
}