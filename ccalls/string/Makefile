.PHONY: all export clean

SRCS := string.c
INCS := string.h

all:

export: ../string.h

../string.h : $(INCS)
	cat $^ >$@

clean:
