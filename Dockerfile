FROM postgres:alpine

COPY generate-ssl-certs.sh /docker-entrypoint-initdb.d/
RUN \
  apk add --no-cache \
    openssl
