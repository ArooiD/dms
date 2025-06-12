package ru.mirea.designvault.storage.service;

import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import ru.mirea.designvault.storage.dto.EmbeddingDto;
import ru.mirea.designvault.storage.dto.IndexDto;
import ru.mirea.designvault.storage.model.DocumentChunk;
import ru.mirea.designvault.storage.repository.DocumentChunkRepository;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class IndexService {
    private final RestTemplate transformClient;
    private final DocumentChunkRepository repository;

    public IndexService(RestTemplateBuilder builder, DocumentChunkRepository repository) {
        this.transformClient = builder.rootUri("http://core.transform:8080/embeding/generate")
                .build();
        this.repository = repository;
    }

    public void indexDocument(IndexDto dto) {
        UUID pid = dto.getPid();
        UUID did = dto.getDid();
        List<String> frags = dto.getFrags();
        for (int i = 0; i < frags.size(); i++) {
            String text = frags.get(i);
            Map<String, Object> requestBody = Map.of("text", text);
            try {
                EmbeddingDto response = transformClient.postForObject(
                        "",
                        requestBody,
                        EmbeddingDto.class);
                if (response != null && response.getEmbeddings() != null) {
                    saveChunkEmbedding(pid, did, i, text, response.getEmbeddings());
                } else {
                    System.err.println("Empty embedding received for fragment " + i);
                }
            } catch (Exception e) {
                System.err.println("Error generating embedding for fragment " + i + ": " + e.getMessage());
            }
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
}
