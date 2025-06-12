package ru.mirea.designvault.storage.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.*;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import ru.mirea.designvault.storage.dto.EmbeddingDto;
import ru.mirea.designvault.storage.dto.FragmentDto;
import ru.mirea.designvault.storage.dto.IndexDto;
import ru.mirea.designvault.storage.dto.SearchSnippetDto;
import ru.mirea.designvault.storage.model.DocumentChunk;
import ru.mirea.designvault.storage.repository.DocumentChunkRepository;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Slf4j
@Service
public class IndexService {
    private final RestTemplate transformClient;
    private final DocumentChunkRepository repository;

    public IndexService(RestTemplateBuilder builder, DocumentChunkRepository repository) {
        this.transformClient = builder
//                .rootUri("http://core.transform:8000")
//                .messageConverters(new MappingJackson2HttpMessageConverter())
                .build();
        this.repository = repository;
    }


    public void indexDocument(IndexDto dto) {
        UUID pid = dto.getPid();
        UUID did = dto.getDid();
        List<String> frags = dto.getFrags();
        for (int i = 0; i < frags.size(); i++) {
            String text = frags.get(i);
            try {
                Float[] embedding = getEmbeddingVector(text);
                if (embedding != null) {
                    saveChunkEmbedding(pid, did, i, text, embedding);
                } else {
                    log.warn("Empty embedding received for fragment " + i);
                }
            } catch (Exception e) {
                log.error("Error generating embedding for fragment " + i + ": " + e.getMessage());
            }
        }
    }

    public Float[] getEmbeddingVector(String text) {
        RestTemplate restTemplate = new RestTemplate();
        String url = "http://core.transform:8000/embedding/generate";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        Map<String, String> body = Map.of("text", text);
        HttpEntity<Map<String, String>> request = new HttpEntity<>(body, headers);
        ResponseEntity<EmbeddingDto> response = restTemplate.postForEntity(url, request, EmbeddingDto.class);
        if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
            return response.getBody().getEmbedding();
        } else {
            throw new RuntimeException("Failed to get embedding, status: " + response.getStatusCode());
        }
    }


    private void saveChunkEmbedding(UUID pid, UUID did, int chunkIndex, String text, Float[] embedding) throws JsonProcessingException {
        String embeddingStr = "'" + new ObjectMapper().writeValueAsString(embedding) + "'";
        String postgresArray = embeddingStr.replace('[', '{').replace(']', '}');
        repository.insertChunk(pid, did, chunkIndex, text, postgresArray);
    }

    public List<SearchSnippetDto> search(String text) throws JsonProcessingException {
        Float[] vector = getEmbeddingVector(text);
        if (vector == null) {
            return Collections.emptyList();
        }
        return repository.searchByEmbedding(vector).stream()
                .map(e -> SearchSnippetDto.builder()
                        .pid(e.getPid())
                        .did(e.getDid())
                        .snippet(e.getContent())
                        .build()
                ).toList();
    }
}

