package ru.mirea.designvault.search.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import ru.mirea.designvault.search.dto.EmbeddingDto;
import ru.mirea.designvault.search.dto.IndexDto;
import ru.mirea.designvault.search.dto.SearchSnippetDto;
import ru.mirea.designvault.search.model.DocumentVersionChunk;
import ru.mirea.designvault.search.repository.DocumentVersionChunkRepository;

import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Pattern;

@Slf4j
@Service
public class DocumentIndexService {
    private final RestTemplate transformClient;
    private final DocumentVersionChunkRepository documentChunkRepository;

    public DocumentIndexService(RestTemplateBuilder builder, DocumentVersionChunkRepository repository) {
        this.transformClient = builder
                .rootUri("http://core.transform:8000")
                .build();
        this.documentChunkRepository = repository;
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
                    log.warn("Empty embedding received for fragment " + i);
                }
            } catch (Exception e) {
                log.error("Error generating embedding for fragment " + i + ": " + e.getMessage());
            }
        }
    }

    public void cleanIndex(IndexDto dto) {
        UUID pid = dto.getPid();
        UUID did = dto.getDid();
        documentChunkRepository.deleteAllByPidAndDid(pid, did);
    }


    public float[] getEmbeddingVector(String text) {
        RestTemplate restTemplate = new RestTemplate();
        String url = "http://core.transform:8000/generate/embedding";
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


    private void saveChunkEmbedding(UUID pid, UUID did, int cid, String text, float[] embedding) {
        DocumentVersionChunk chunk = DocumentVersionChunk.builder()
                .pid(pid)
                .did(did)
                .cid(cid)
                .content(text)
                .embedding(embedding)
                .build();
        documentChunkRepository.save(chunk);
    }

    public List<SearchSnippetDto> vectorSearch(String text, Integer limit) {
        float[] vector = getEmbeddingVector(text);
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < vector.length; i++) {
            if (i > 0) sb.append(", ");
            sb.append(vector[i]);
        }
        sb.append("]");
        String vectorString = sb.toString();
        String[] words = text.trim().split("\\s+");
        StringBuilder tsquery = new StringBuilder();
        for (int i = 0; i < words.length; i++) {
            if (i > 0) tsquery.append(" & ");
            tsquery.append(words[i]).append(":*");
        }
        String tsQueryString = tsquery.toString();
        return documentChunkRepository.findNearestNeighborsWithFullText(vectorString, tsQueryString, limit)
                .stream()
                .map(chunk -> SearchSnippetDto.builder()
                        .pid(chunk.getPid())
                        .did(chunk.getDid())
                        .snippet(highlightText(chunk.getContent(), text))
                        .score(chunk.getDistance())
                        .build())
                .toList();
    }

    public String highlightText(String snippet, String query) {
        if (snippet == null || query == null) return snippet;
        String[] words = query.trim().split("\\s+");
        for (String word : words) {
            snippet = snippet.replaceAll("(?i)" + Pattern.quote(word), "<mark>$0</mark>");
        }
        return snippet;
    }
}

