versions = \
	9.5 \
	9.6 \
	10 \
	11 \
	12 \
	13 \
	latest

test: $(versions)

$(versions):
	make --directory $@ test clean

.PHONY: $(versions)
