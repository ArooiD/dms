FROM postgres:15

RUN apt-get update \
 && apt-get install -y postgresql-server-dev-15 build-essential git \
 && git clone --branch v0.5.1 https://github.com/pgvector/pgvector.git \
 && cd pgvector && make && make install

COPY init.sql docker-entrypoint-initdb.d/init.sql

CMD ["postgres", "-c", "max_connections=5000"]
