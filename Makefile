image = ghcr.io/infrastructure-as-code/postgres
versions = \
	debian \
	alpine

alpine_tags = \
	11-alpine \
	12-alpine \
	13-alpine \
	14-alpine \
	15-alpine

debian_tags = \
	11-bullseye \
	12 \
	13 \
	14 \
	15

all: $(alpine_tags) $(debian_tags)

$(alpine_tags):
	make build distro=alpine version=$@

$(debian_tags):
	make build distro=debian version=$@

build:
	$(eval tag = $(image):$(version))
	docker build --rm \
		--tag $(tag) \
		--file $(distro).Dockerfile \
		--build-arg base_image=public.ecr.aws/docker/library/postgres:$(version) \
		.
	IMAGE=$(tag) docker-compose -f docker-compose.test.yml run sut
	IMAGE=$(tag) docker-compose -f docker-compose.test.yml down

.PHONY: $(alpine_tags) $(debian_tags)
