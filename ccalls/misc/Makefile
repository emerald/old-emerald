.PHONY: all export clean

SRCS := hello.c
INCS := hello.h exit.h

all:

export: ../misc.h

../misc.h: $(INCS)
	cat $^ > $@

clean:
