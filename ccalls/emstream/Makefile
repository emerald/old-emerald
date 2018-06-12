.PHONY: all export clean

SRCS := emstream.c
INCS := emstream.h

all:

export: ../emstream.h

../emstream.h : $(INCS)
	cat $(INCS) >$@

clean:
