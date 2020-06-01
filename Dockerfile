FROM postgres:alpine

COPY build.sh /
RUN \
  /build.sh && \
  rm build.sh

CMD ["postgres", "-cssl=on", "-cssl_cert_file=/data/ssl/certs/server.crt", "-cssl_key_file=/data/ssl/certs/server.key"]
