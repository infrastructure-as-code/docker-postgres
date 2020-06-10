versions = \
	9.5-alpine \
	9.6-alpine \
	10-alpine \
	11-alpine \
	12-alpine \
	13-alpine \
	alpine

test: $(versions)

$(versions):
	make --directory $@ test clean

.PHONY: $(versions)
