package ru.mirea.designvault.storage.controller;


import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ru.mirea.designvault.storage.dto.IndexDto;
import ru.mirea.designvault.storage.dto.SearchSnippetDto;
import ru.mirea.designvault.storage.service.IndexService;

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
    public ResponseEntity<List<SearchSnippetDto>> search(@RequestParam Map<String, String> query) {
        List<SearchSnippetDto> result = indexService.search(query.get("text"));
        return ResponseEntity.ok(result);
    }
}
