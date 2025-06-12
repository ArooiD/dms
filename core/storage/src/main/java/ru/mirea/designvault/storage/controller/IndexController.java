package ru.mirea.designvault.storage.controller;


import com.fasterxml.jackson.core.JsonProcessingException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ru.mirea.designvault.storage.dto.IndexDto;
import ru.mirea.designvault.storage.dto.SearchSnippetDto;
import ru.mirea.designvault.storage.service.IndexService;

import java.util.Collections;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping(value = "index")
public class IndexController {

    private final IndexService indexService;

    public IndexController(IndexService indexService) {
        this.indexService = indexService;
    }

    @PostMapping("document")
    public ResponseEntity<String> indexChunk(@RequestBody IndexDto dto) {
        try {
            indexService.indexDocument(dto);
            return ResponseEntity.ok("Indexed successfully");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Indexing failed: " + e.getMessage());
        }
    }

    @GetMapping("search")
    public ResponseEntity<List<SearchSnippetDto>> search(@RequestBody Map<String, String> query) throws JsonProcessingException {
        String text = query.get("query");
        if (text == null || text.isBlank()) {
            return ResponseEntity.badRequest().body(Collections.emptyList());
        }
        List<SearchSnippetDto> result = indexService.search(text);
        return ResponseEntity.ok(result);
    }
}
