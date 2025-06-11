package ru.mirea.designvault.gateway.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;
import ru.mirea.designvault.gateway.dto.ResponseDto;

import java.net.URI;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Slf4j
@Service
public class ProjectService {
    private final RestTemplate restTemplate;


    public ProjectService(RestTemplateBuilder builder) {
        this.restTemplate = builder
                .rootUri("http://core.storage:8000")
                .build();
    }


    public List<Object> getProjects(UUID uid) {
        log.info("Get projects for user {}", uid);
        List<Object> response = restTemplate.getForObject(
                "/projects/private?uid={uid}",
                List.class,
                uid
        );
        return response;
    }
}
