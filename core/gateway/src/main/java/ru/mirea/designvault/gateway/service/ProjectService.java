package ru.mirea.designvault.gateway.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;
import ru.mirea.designvault.gateway.dto.ProjectDto;
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


    public ResponseDto getProjects(UUID uid) {
        log.info("Get projects for user {}", uid);
        List<Object> response = restTemplate.getForObject(
                "/projects/private?uid={uid}",
                List.class,
                uid
        );

        return ResponseDto.builder()
                .count(response.size())
                .resultSet(response)
                .build();
    }

    public Object createProject(UUID uid, ProjectDto project) {
        return restTemplate.postForObject(
                "/projects?uid={uid}",
                project,
                Object.class,
                uid
        );
    }

    public Object deleteProject(UUID uid, UUID pid) {
        restTemplate.delete(
                "/projects?uid={uid}&pid={pid}",
                uid,
                pid
        );
        return true;
    }

    public ProjectDto getProject(UUID uid, UUID pid) {
        ResponseEntity<ProjectDto> response = restTemplate.getForEntity(
                "/projects?uid={uid}&pid={pid}",
                ProjectDto.class,
                uid,
                pid
        );
        return response.getBody();
    }
}
