package ru.mirea.designvault.storage.controller;


import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ru.mirea.designvault.storage.dto.IndexDto;
import ru.mirea.designvault.storage.service.IndexService;

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

}
