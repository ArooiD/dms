FROM nginx:latest

RUN apt-get update && \
    apt-get install -y gettext-base openssl && \
    rm -rf /var/lib/apt/lists/*

ENV DOMAIN_NAME=localhost
ENV SSL=false

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
