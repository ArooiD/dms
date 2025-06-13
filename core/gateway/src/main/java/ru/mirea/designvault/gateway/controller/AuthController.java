package ru.mirea.designvault.gateway.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ru.mirea.designvault.gateway.dto.AuthDto;
import ru.mirea.designvault.gateway.service.IdentityService;

import java.util.Map;

@RestController
@RequestMapping("auth")
@Tag(name = "01 - Auth API", description = "Авторизация в системе")
public class AuthController {
    private final IdentityService authService;

    public AuthController(IdentityService authService) {
        this.authService = authService;
    }

    @PostMapping("login")
    @Operation(summary = "User login", description = "Аутентификация пользователя и получение токена", operationId = "authLogin")
    public ResponseEntity<Map> login(@RequestBody AuthDto dto) {
        Map token = authService.getToken(dto);
        return ResponseEntity.ok(token);
    }
}
