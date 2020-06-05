FROM postgres:10-alpine

RUN \
  apk add --no-cache \
    openssl
COPY generate-ssl-certs.sh /docker-entrypoint-initdb.d/
