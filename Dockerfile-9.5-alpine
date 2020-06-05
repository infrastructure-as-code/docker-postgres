FROM postgres:9.5-alpine

RUN \
  apk add --no-cache \
    openssl
COPY generate-ssl-certs.sh /docker-entrypoint-initdb.d/
