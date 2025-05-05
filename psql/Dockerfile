FROM postgres:15

COPY init_schema docker-entrypoint-initdb.d

CMD ["postgres", "-c", "max_connections=5000"]