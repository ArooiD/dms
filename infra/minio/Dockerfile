FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y curl bash wget ca-certificates && rm -rf /var/lib/apt/lists/*

ENV MINIO_VERSION RELEASE.2025-06-01T00-00-00Z
RUN wget https://dl.min.io/server/minio/release/linux-amd64/minio -O /usr/local/bin/minio && \
    chmod +x /usr/local/bin/minio

EXPOSE 9000 9090

ENTRYPOINT ["minio"]
CMD ["server", "/data", "--console-address", ":9090"]
