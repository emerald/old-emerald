.PHONY: test clean

SHELL:=/usr/bin/env bash

WD:=$(shell pwd)

test: cctab.h cctab.c gencctab.txt
	test $(shell git status --porcelain $? | wc -l ) = 0

cctab.h: ../../gencctab
	EMERALDROOT="$(WD)" \
	  PATH="${PATH}:$(WD)/../../" \
	  ../../gencctab \
	  emstream.o \
	  misk.o \
	  rand.o \
	  string.o &> gencctab.txt

cctab.c: cctab.h

gencctab.txt: cctab.h

clean:
	git checkout cctab.h cctab.c
