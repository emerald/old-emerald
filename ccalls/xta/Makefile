.PHONY: all export clean

SRCS :=
INCS := xta.h

all:

# begin --- Emerald interpreter targets ---

export: xsed ../xta.h

../xta.h: $(INCS)
	cat $^ > $@

xsed: ../xsed.c xta.va
	rm -f xta.c
	../xsed < xta.va > xta.c

clean:

# end --- Emerald interpreter targets ---
