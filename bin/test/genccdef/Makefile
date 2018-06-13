.PHONY: test lib/ccdef clean

DOTHS := \
	emstream.h \
	string.h \
	rand.h \
	misk.h \
	regexp.h \
	xforms.h \
	xliba.h \
	xta.h \
	xma.h \
	bani.h \
	myristream.h

test: lib/ccdef
	test $(shell git status --porcelain lib/ccdef | wc -l ) = 0

lib/ccdef: ../../genccdef $(DOTHS)
	EMERALDROOT="$(PWD)" $^

clean:
	git checkout lib/ccdef
