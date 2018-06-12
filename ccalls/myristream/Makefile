.PHONY: all export clean

SRCS := myristream.c
INCS := myristream.h

all:

export: ../myristream.h

../myristream.h : $(INCS)
	cat $^ >$@

clean:
