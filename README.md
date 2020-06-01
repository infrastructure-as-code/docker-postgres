# Postgres Docker Image with Self-Signed SSL Certs

The [official Postgres image](https://hub.docker.com/_/postgres) comes without any SSL certificates, leaving users to create the functionality for themselves.  The [infrastructureascode/postgres](https://hub.docker.com/repository/docker/infrastructureascode/postgres) Docker image create here aims to add SSL support by using self-signed SSL certificates.


## Automated Builds

[![DockerHub Badge](http://dockeri.co/image/infrastructureascode/postgres)](https://hub.docker.com/r/infrastructureascode/postgres/)

Images are automatically built on [Docker Hub]()'s infrastructure with every push to this repo, as well as when the base Postgres images are updated.


## Security Note

Please make sure you understand the security implications of using self-signed certificates of you use this for anything other than dev or test purposes.  The [Postgresql libpq-ssl](https://www.postgresql.org/docs/11/libpq-ssl.html#LIBPQ-SSL-PROTECTION) page has a nice table describing the SSL modes that you should review.


## References

1. https://gist.github.com/mrw34/c97bb03ea1054afb551886ffc8b63c3b
1. https://www.postgresql.org/docs/11/ssl-tcp.html
1. https://www.postgresql.org/docs/11/libpq-ssl.html#LIBPQ-SSL-PROTECTION
