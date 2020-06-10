compose_file = docker-compose.test.yml
dc = docker-compose -f $(compose_file)

build up:
	$(dc) $@

test:
	$(dc) run --rm sut

clean:
	$(dc) down --rmi all
