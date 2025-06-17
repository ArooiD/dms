package ru.mirea.designvault.search.controller;


import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ru.mirea.designvault.search.dto.IndexDto;
import ru.mirea.designvault.search.dto.SearchSnippetDto;
import ru.mirea.designvault.search.service.DocumentIndexService;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Collections;
import java.util.List;
import java.util.Map;

@Slf4j
@CrossOrigin(origins = "*")
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
            indexService.indexDocument(dto);
            return ResponseEntity.ok("Indexed successfully");
        } catch (Exception e) {
            log.error(e.getMessage(), e);
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
    public ResponseEntity<List<SearchSnippetDto>> search(
            @RequestParam(name = "query") String query,
            @RequestParam(name = "count") String count) throws UnsupportedEncodingException {
        query = URLDecoder.decode(query, StandardCharsets.UTF_8);
        List<SearchSnippetDto> result = indexService.vectorSearch(query, Integer.parseInt(count));
        return ResponseEntity.ok(result);
    }
}
