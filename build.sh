#!/bin/sh
set -euxo pipefail

SSL_DOMAIN=pg.local
SSL_CERT_DIR=/data/ssl/certs

apk add --no-cache --virtual vsslpackage \
  openssl

mkdir -p "${SSL_CERT_DIR}"
openssl req -new -x509 -days 3650 -nodes -text \
  -out "${SSL_CERT_DIR}/server.crt" \
  -keyout "${SSL_CERT_DIR}/server.key" \
  -subj "/CN=${SSL_DOMAIN}"
chown postgres:postgres \
  "${SSL_CERT_DIR}/server.crt" \
  "${SSL_CERT_DIR}/server.key"
chmod og-rwx "${SSL_CERT_DIR}/server.key"

apk del vsslpackage
