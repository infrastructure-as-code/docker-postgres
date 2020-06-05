SHELL := /bin/bash
version ?= 11
target_image = infrastructureascode/postgres:$(version)
dockerfile = Dockerfile-$(version)
versions = \
	latest alpine \
	9.5 9.5-alpine \
	9.6 9.6-alpine \
	10 10-alpine \
	11 11-alpine \
	12 12-alpine

all: $(versions)

build:
	docker build --rm \
		--tag $(target_image) \
		--file $(dockerfile) \
		.

run:
	docker run --rm -it \
		-e POSTGRES_PASSWORD=helloworld123 \
		-p 5432:5432 \
		$(target_image)

test:
	$(eval container_name = server-$(version))
	$(eval port = 35432)
	$(eval network_name = pg-network-$(version))
	-docker kill $(container_name)
	-docker network rm $(network_name)
	docker network create $(network_name)
	docker run \
		--name $(container_name) \
		--network $(network_name) \
		--rm -it \
		--detach \
		-e POSTGRES_USER=postgres \
		-e POSTGRES_PASSWORD=helloworld123 \
		-p $(port):5432 \
		$(target_image)
	docker run \
		--rm -it \
		--network $(network_name) \
		-e PGHOST=$(container_name) \
		-e PGPORT=5432 \
		-e PGSSLMODE=require \
		-e PGUSER=postgres \
		-e PGPASSWORD=helloworld123 \
		postgres:$(version) \
		/bin/sh -eux -c "sleep 5 && pg_isready --timeout=300 && psql -c 'show ssl;'"
	docker kill $(container_name)
	docker network rm $(network_name)

clean:
	docker system prune --all --force

$(versions):
	$(eval version=$@)
	make build version=$(version)
	make test version=$(version)
