package ru.mirea.designvault.gateway.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import ru.mirea.designvault.gateway.dto.AuthDto;
import ru.mirea.designvault.gateway.service.AuthService;

import java.util.Map;

@RestController
public class AuthController {
    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping
    public ResponseEntity<Map> login(@RequestBody AuthDto dto) {
        return ResponseEntity.ok(authService.getToken(dto));
    }
}
