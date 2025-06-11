FROM postgres:15

#RUN apt-get update && apt-get install -y \
#    postgresql-server-dev-15 \
#    build-essential \
#    git \
#  && rm -rf /var/lib/apt/lists/*
#
#RUN git clone --depth 1 https://github.com/pgvector/pgvector.git /tmp/pgvector && \
#    cd /tmp/pgvector && \
#    make && make install && \
#    rm -rf /tmp/pgvector

COPY init.sql docker-entrypoint-initdb.d/init.sql

CMD ["postgres", "-c", "max_connections=5000"]
