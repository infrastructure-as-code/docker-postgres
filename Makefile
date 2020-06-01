version ?= 11
target_image = infrastructureascode/postgres:$(version)-alpine
dockerfile = Dockerfile-$(version)

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

clean:
	docker system prune --all --force
