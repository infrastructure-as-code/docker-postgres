image = ghcr.io/infrastructure-as-code/postgres
versions = \
	debian \
	alpine

alpine_tags = \
	9.5-alpine \
	9.6-alpine \
	10-alpine \
	11-alpine \
	12-alpine \
	13-alpine

debian_tags = \
	9.5 \
	9.6 \
	10 \
	11 \
	12 \
	13

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
		--build-arg base_image=postgres:$(version) \
		.
	IMAGE=$(tag) docker-compose -f docker-compose.test.yml run sut
	IMAGE=$(tag) docker-compose -f docker-compose.test.yml down

.PHONY: $(alpine_tags) $(debian_tags)
