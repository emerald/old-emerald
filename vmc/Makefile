CFLAGS = -I. -Wall -Wextra -pedantic -std=c11 ${EXTRA_CFLAGS}
INSTALLIN = $(EMERALDROOT)/bin/$(EMERALDARCH)
OBJ = vmclex.o vmcpar.o semantic.o trace.o \
		iisc.o iset.o slist.o sisc.o ilist.o strings.o

.c.o:;	$(CC) -c $(CFLAGS) $*.c

CC = gcc -g

vmc:	$(OBJ) Makefile
	$(CC) $(CFLAGS) -o vmc $(OBJ)

vmclex.c: vmclex.l Makefile
	lex -o vmclex.c vmclex.l

vmclex.o:	vmcpar.h Makefile

vmcpar.h vmcpar.c:	vmcpar.y Makefile
	yacc -o vmcpar.c -d vmcpar.y

vmc.o:	tokenNames.c vmcpar.h Makefile

tokenNames.c:	vmcpar.y Makefile
	csh MAKETN

clean:
	rm -f vmc $(OBJ) tokenNames.c vmcpar.h vmcpar.c vmclex.c core

install: $(INSTALLIN)/vmc

$(INSTALLIN)/vmc : vmc Makefile
	if issymlink $@ ; then \
	  true ; \
	else \
	  rm -f $@ ; \
	  cp vmc $@ ; \
	  chmod g+w $@ ; \
	fi

lint:
	lint -bh *.c | egrep -v 'pointer alignment'

.PHONY: clean install lint
