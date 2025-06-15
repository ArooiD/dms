package ru.mirea.designvault.search.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;
import ru.mirea.designvault.search.dto.EmbeddingDto;
import ru.mirea.designvault.search.dto.IndexDto;
import ru.mirea.designvault.search.dto.SearchSnippetDto;
import ru.mirea.designvault.search.model.DocumentVersionChunk;
import ru.mirea.designvault.search.repository.DocumentVersionChunkRepository;

import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

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

    @Transactional
    public int indexDocument(IndexDto dto) {
        UUID pid = UUID.fromString(dto.getPid().replace("\"", ""));
        UUID did = UUID.fromString(dto.getDid().replace("\"", ""));
        Integer ver = Integer.parseInt(dto.getVer());
        List<String> frags = dto.getFrags();
        log.info("HERE -> 1");
        ExecutorService executor = Executors.newFixedThreadPool(10);
        List<Future<DocumentVersionChunk>> futures = new ArrayList<>();
        for (int i = 0; i < frags.size(); i++) {
            final int index = i;
            futures.add(executor.submit(() -> {
                String text = frags.get(index);
                try {
                    return DocumentVersionChunk.builder()
                            .pid(pid)
                            .did(did)
                            .ver(ver)
                            .cid(index)
                            .content(text.replaceAll("\\x00", ""))
//                            .embedding(embedding)
                            .build();
////                    float[] embedding = getEmbeddingVector(text); // REST call
////                    if (embedding != null) {
//
//                    } else {
//                        log.warn("Empty embedding for fragment {}", index);
//                    }
                } catch (Exception e) {
                    log.error("Error generating embedding for fragment {}: {}", index, e.getMessage());
                }
                return null;
            }));
        }
        List<DocumentVersionChunk> chunks = new ArrayList<>();
        for (Future<DocumentVersionChunk> future : futures) {
            try {
                DocumentVersionChunk chunk = future.get();
                if (chunk != null) {
                    chunks.add(chunk);
                }
            } catch (Exception e) {
                log.error("Error retrieving future result: {}", e.getMessage());
            }
        }
        executor.shutdown();
        if (!chunks.isEmpty()) {
            var e = documentChunkRepository.saveAll(chunks);
            log.info("Saved {} chunks to database", chunks.size());
            return List.of(e).size();
        }
        return frags.size();
    }

    public void cleanIndex(IndexDto dto) {
        UUID pid = UUID.fromString(dto.getPid());
        UUID did = UUID.fromString(dto.getDid());
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
            log.error("Error generating embedding for text " + text);
            return null;
//            throw new RuntimeException("Failed to get embedding, status: " + response.getStatusCode());
        }
    }

    @Transactional
    public DocumentVersionChunk saveChunkEmbedding(UUID pid, UUID did, Integer ver, int cid, String text, float[] embedding) {
        DocumentVersionChunk chunk = DocumentVersionChunk.builder()
                .pid(pid)
                .did(did)
                .ver(ver)
                .cid(cid)
                .content(text)
                .build();
        return documentChunkRepository.save(chunk);
    }

    @Transactional
    public Iterable<DocumentVersionChunk> saveChunkEmbeddingBatch(List<DocumentVersionChunk> batch) {
        return documentChunkRepository.saveAll(batch);
    }


    public List<SearchSnippetDto> vectorSearch(String text, Integer limit) {
//        float[] vector = getEmbeddingVector(text);
//        StringBuilder sb = new StringBuilder("[");
//        for (int i = 0; i < vector.length; i++) {
//            if (i > 0) sb.append(", ");
//            sb.append(vector[i]);
//        }
//        sb.append("]");
//        String vectorString = sb.toString();
        String[] words = text.trim().split("\\s+");
        StringBuilder tsquery = new StringBuilder();
        for (int i = 0; i < words.length; i++) {
            if (i > 0) tsquery.append(" & ");
            tsquery.append(words[i]).append(":*");
        }
        String tsQueryString = tsquery.toString();
        return documentChunkRepository.findNearestNeighborsWithFullText(tsQueryString, limit)
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

