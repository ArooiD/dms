package ru.mirea.dms.search.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.NimbusJwtDecoder;
import org.springframework.web.client.RestTemplate;

@Configuration
public class KeyCloakConfig {
    private final String kk_host;
    private final String kk_port;
    private final String kk_realm;

    public KeyCloakConfig(@Value("${KC_HOST:localhost}") String kk_host,
                          @Value("${KC_PORT:8080}") String kk_port,
                          @Value("dms") String kk_realm
    ) {
        this.kk_host = kk_host;
        this.kk_port = kk_port;
        this.kk_realm = kk_realm;
    }

    @Bean
    public JwtDecoder jwtDecoder() {
        return NimbusJwtDecoder.withJwkSetUri("http://" + kk_host + ":" + kk_port + "/realms/" + kk_realm + "/protocol/openid-connect/certs")
                .restOperations(new RestTemplate())
                .build();
    }
}
