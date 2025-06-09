FROM postgres:15

COPY init.sql docker-entrypoint-initdb.d/init.sql

CMD ["postgres", "-c", "max_connections=5000"]