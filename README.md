# Postgres Docker Image with Self-Signed SSL Certs

The [official Postgres image](https://hub.docker.com/_/postgres) comes without any SSL certificates, leaving users to create the functionality for themselves.  The [infrastructureascode/postgres](https://hub.docker.com/repository/docker/infrastructureascode/postgres) Docker image create here aims to add SSL support by using self-signed SSL certificates.


## Automated Builds

[![DockerHub Badge](http://dockeri.co/image/infrastructureascode/postgres)](https://hub.docker.com/r/infrastructureascode/postgres/)

In order to ensure the provenance of the images, all images are automatically built on [Docker Hub]()'s infrastructure with every push to this repo, as well as when the base Postgres images are updated.

## Supported Tags and Respective Dockerfiles

* [`9.5-alpine`](https://github.com/infrastructure-as-code/docker-postgres/blob/master/Dockerfile-9.5)
* [`9.6-alpine`](https://github.com/infrastructure-as-code/docker-postgres/blob/master/Dockerfile-9.6)
* [`10-alpine`](https://github.com/infrastructure-as-code/docker-postgres/blob/master/Dockerfile-10)
* [`11-alpine`](https://github.com/infrastructure-as-code/docker-postgres/blob/master/Dockerfile-11)
* [`12-alpine`](https://github.com/infrastructure-as-code/docker-postgres/blob/master/Dockerfile-12)


## Usage

Starting a container.

```
docker run --rm -it \
  -e POSTGRES_PASSWORD=password \
  infrastructureascode/postgres:11-alpine
```

## Environment Variables

Since this image is extended from the official Postgresql images, it also has the same basic funcationality as the official images, so please review [the instructions from the official image](https://github.com/docker-library/docs/blob/master/postgres/README.md) as well.

Additionally, the following environment variables provide a little bit of control of the self-signed SSL certificates.

| Environment Variable | Default Value | Description |
|----------------------|---------------|-------------|
| `SSL_DOMAIN`         | `pg.local`    | The domain used in the self-signed SSL certificate |
| `SSL_DAYS`           | 3650          | The number of days the self-signed SSL certificates are valid for |
| `SSL_ONLY`           | `true`        | Should all connections be SSL-only? |


## Security Note

Self-signed SSL certifications are generated when a container is started for the first time (so that at least we don't all have the same certificates).


Please make sure you understand the security implications of using self-signed certificates of you use this for anything other than dev or test purposes.  The [Postgresql libpq-ssl](https://www.postgresql.org/docs/11/libpq-ssl.html#LIBPQ-SSL-PROTECTION) page has a nice table describing the SSL modes that you should review.


## References

1. https://gist.github.com/mrw34/c97bb03ea1054afb551886ffc8b63c3b
1. https://www.postgresql.org/docs/11/ssl-tcp.html
1. https://www.postgresql.org/docs/11/libpq-ssl.html#LIBPQ-SSL-PROTECTION
