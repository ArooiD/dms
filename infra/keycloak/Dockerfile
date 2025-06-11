FROM quay.io/keycloak/keycloak:25.0.0

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_LOG_LEVEL=INFO
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin
ENV KC_DB=postgres
ENV KC_DB_URL=jdbc:postgresql://infra.kcsql:5432/keycloak
ENV KC_DB_USERNAME=postgres
ENV KC_DB_PASSWORD=root

RUN /opt/keycloak/bin/kc.sh build

EXPOSE 8080
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev", "--verbose"]