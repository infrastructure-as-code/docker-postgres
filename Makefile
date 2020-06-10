versions = \
	debian \
	alpine

test: $(versions)

$(versions):
	make --directory $@ test

.PHONY: $(versions)
