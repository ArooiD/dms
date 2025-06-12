package ru.mirea.designvault.storage.service;

import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import ru.mirea.designvault.storage.dto.EmbeddingDto;
import ru.mirea.designvault.storage.dto.IndexDto;
import ru.mirea.designvault.storage.dto.SearchSnippetDto;
import ru.mirea.designvault.storage.model.DocumentChunk;
import ru.mirea.designvault.storage.repository.DocumentChunkRepository;

import java.util.*;

@Service
public class IndexService {
    private final RestTemplate transformClient;
    private final DocumentChunkRepository repository;

    public IndexService(RestTemplateBuilder builder, DocumentChunkRepository repository) {
        this.transformClient = builder.rootUri("http://core.transform:8000")
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
                float[] embedding = getEmbeddingVector(text);
                if (embedding != null) {
                    saveChunkEmbedding(pid, did, i, text, embedding);
                } else {
                    System.err.println("Empty embedding received for fragment " + i);
                }
            } catch (Exception e) {
                System.err.println("Error generating embedding for fragment " + i + ": " + e.getMessage());
            }
        }
    }

    private float[] getEmbeddingVector(String text) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        Map<String, String> body = Map.of("text", text);
        HttpEntity<Map<String, String>> request = new HttpEntity<>(body, headers);
        try {
            ResponseEntity<EmbeddingDto> response = transformClient.postForEntity(
                    "/embedding/generate",
                    request,
                    EmbeddingDto.class
            );
            if (response.getBody() == null || response.getBody().getEmbeddings() == null) {
                throw new IllegalStateException("Empty embedding vector from response");
            }
            return response.getBody().getEmbeddings();
        } catch (Exception e) {
            throw new RuntimeException("Failed to retrieve embedding vector: " + e.getMessage(), e);
        }
    }


    private void saveChunkEmbedding(UUID pid, UUID did, int chunkIndex, String text, float[] embedding) {
        DocumentChunk chunk = DocumentChunk.builder()
                .pid(pid)
                .did(did)
                .cid(chunkIndex)
                .content(text)
                .embedding(embedding)
                .build();
        repository.save(chunk);
    }

    public List<SearchSnippetDto> search(String text) {
        float[] vector = getEmbeddingVector(text);
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

