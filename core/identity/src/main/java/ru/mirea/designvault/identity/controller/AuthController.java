package ru.mirea.designvault.identity.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import ru.mirea.designvault.identity.dto.AuthDto;
import ru.mirea.designvault.identity.service.AuthService;

import java.util.Map;

@RestController
public class AuthController {
    private final AuthService authService;
    private final Logger logger;

    public AuthController(AuthService authService) {
        this.authService = authService;
        this.logger = LoggerFactory.getLogger(this.getClass());
    }

    @PostMapping("/token")
    public ResponseEntity<Map> getAccessToken(@RequestBody AuthDto dto) {
        try {
            Map tokenResponse = authService.getAccessToken(dto.getUsername(), dto.getPassword());
            return ResponseEntity.ok(tokenResponse);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return ResponseEntity.status(400).body(Map.of("error", "Invalid credentials or unable to obtain token"));
        }
    }
}
