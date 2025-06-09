//package ru.mirea.designvault.search.config;
//
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.core.convert.converter.Converter;
//import org.springframework.security.core.GrantedAuthority;
//import org.springframework.security.core.authority.SimpleGrantedAuthority;
//import org.springframework.security.oauth2.jwt.Jwt;
//
//import java.util.ArrayList;
//import java.util.Collection;
//import java.util.List;
//import java.util.stream.Collectors;
//
//@Configuration
//public class KeycloakRoleConverter implements Converter<Jwt, Collection<GrantedAuthority>> {
//    private final Logger logger;
//
//    public KeycloakRoleConverter() {
//        this.logger = LoggerFactory.getLogger(this.getClass());
//    }
//
//    @Override
//    public Collection<GrantedAuthority> convert(Jwt jwt) {
//        Object realmAccess = jwt.getClaimAsMap("realm_access").get("roles");
//        List<String> roles = new ArrayList<>();
//        if (realmAccess instanceof List<?>) {
//            roles = ((List<?>) realmAccess).stream()
//                    .filter(String.class::isInstance)
//                    .map(String.class::cast)
//                    .toList();
//        }
//        return roles.stream()
//                .map(role -> new SimpleGrantedAuthority("ROLE_" + role))
//                .collect(Collectors.toList());
//    }
//}