package ru.mirea.dms.auth.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import ru.mirea.dms.auth.dto.AuthDto;
import ru.mirea.dms.auth.service.AuthService;

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
    public ResponseEntity<Map<String, Object>> getAccessToken(@RequestBody AuthDto dto) {
        try {
            Map<String, Object> tokenResponse = authService.getAccessToken(dto.getUsername(), dto.getPassword());
            return ResponseEntity.ok(tokenResponse);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return ResponseEntity.status(400).body(Map.of("error", "Invalid credentials or unable to obtain token"));
        }
    }
}
