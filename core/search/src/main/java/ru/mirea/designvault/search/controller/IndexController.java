package ru.mirea.designvault.search.controller;


import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ru.mirea.designvault.search.dto.IndexDto;
import ru.mirea.designvault.search.dto.SearchSnippetDto;
import ru.mirea.designvault.search.service.DocumentIndexService;

import java.util.Collections;
import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping(value = "index")
public class IndexController {

    private final DocumentIndexService indexService;

    public IndexController(DocumentIndexService indexService) {
        this.indexService = indexService;
    }

    @PostMapping("document")
    public ResponseEntity<String> indexChunk(@RequestBody IndexDto dto) {
        try {
            log.info("Index chunk: {} {} {} {}", dto.getPid(), dto.getDid(), dto.getVer(), dto.getFrags().size());
            var i = indexService.indexDocument(dto);
            return ResponseEntity.ok("Indexed successfully" + i);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Indexing failed: " + e.getMessage());
        }
    }

    @DeleteMapping("document")
    public ResponseEntity<String> clearChunk(@RequestBody IndexDto dto) {
        try {
            indexService.cleanIndex(dto);
            return ResponseEntity.ok("Indexed successfully");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Clean failed: " + e.getMessage());
        }
    }


    @GetMapping("search")
    public ResponseEntity<List<SearchSnippetDto>> search(@RequestBody Map<String, String> query) {
        String text = query.get("query");
        Integer count = Integer.parseInt(query.get("count"));
        if (text == null || text.isBlank()) {
            return ResponseEntity.badRequest().body(Collections.emptyList());
        }
        List<SearchSnippetDto> result = indexService.vectorSearch(text, count);
        return ResponseEntity.ok(result);
    }
}
