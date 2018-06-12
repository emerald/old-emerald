.PHONY: all export clean

SRCS :=
INCS := xma.h

all:

# begin --- Emerald interpreter targets ---

export: ../xma.h

../xma.h: $(INCS)
	cat $^ > $@

xsed: ../xsed.c xma.va
	rm -f xma.c
	../xsed < xma.va > xma.c

clean:

# end --- Emerald interpreter targets ---
