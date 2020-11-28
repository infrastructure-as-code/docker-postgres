#!/bin/sh
set -eu

SSL_DOMAIN=${SSL_DOMAIN:="pg.local"}
SSL_DAYS=${SSL_DAYS:=3650}
SSL_ONLY=${SSL_ONLY:="true"}

echo "Generating self-signed SSL certificates valid for ${SSL_DAYS} days with ${SSL_DOMAIN} domain"
openssl req -new -x509 -days ${SSL_DAYS} -nodes -text \
  -out "${PGDATA}/server.crt" \
  -keyout "${PGDATA}/server.key" \
  -subj "/CN=${SSL_DOMAIN}"
chown postgres:postgres \
  "${PGDATA}/server.crt" \
  "${PGDATA}/server.key"
chmod og-rwx "${PGDATA}/server.key"

echo "Updating postgresql.conf with SSL configurations"
echo "
ssl = on
#ssl_ca_file = '${PGDATA}/root.crt'
ssl_cert_file = '${PGDATA}/server.crt'
ssl_key_file = '${PGDATA}/server.key'
ssl_prefer_server_ciphers = on
ssl_ciphers = 'HIGH:MEDIUM:+3DES:!aNULL'
" >> "${PGDATA}/postgresql.conf"

if test "${SSL_ONLY}" = "true"; then
  echo "Enforcing SSL-only client connections"
  sed -i -e 's/^host all all all/hostssl all all all/' "${PGDATA}/pg_hba.conf"
fi
