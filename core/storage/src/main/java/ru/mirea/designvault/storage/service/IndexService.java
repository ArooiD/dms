package ru.mirea.designvault.storage.service;

import org.springframework.boot.web.client.RestTemplateBuilder;
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
        this.transformClient = builder.rootUri("http://core.transform:8080/embedding/generate")
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
        Map<String, String> request = Map.of("text", text);
        EmbeddingDto response = transformClient.postForObject("", request, EmbeddingDto.class);
        if (response != null) {
            return response.getEmbeddings();
        }
        return null;
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

