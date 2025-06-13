package ru.mirea.designvault.gateway.service;


import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import ru.mirea.designvault.gateway.dto.AuthDto;

import java.util.Map;

@Service
public class IdentityService {
    private final RestTemplate restTemplate;

    public IdentityService(RestTemplateBuilder builder) {
        this.restTemplate = builder
                .rootUri("http://core.identity:8000")
                .build();
    }

    public Map getToken(AuthDto dto){
        return restTemplate.postForObject("/token", dto, Map.class);
    }
}
