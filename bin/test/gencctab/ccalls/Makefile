#
# Makefile for Emerald ccalls library
#
# invoke using emmake (i.e. not just make).  Emmake is located in
# ${EMERALDROOT}/bin or ${EMERALDRROT}/bin/${EMERALDARCH}.
#
#
# We list the subdirectories here explicitly, because in order to maintain
# compatibility with old already compiled code, we need to deal with them in
# the same order, so that they get the same identifiers.  
#

ifndef EMMAKE
  $(error EMMAKE is not declcared; try emmake, rather than make.)
endif

DOTHS = \
	emstream.h \
	string.h \
	rand.h \
	misk.h

doths:
	@echo $(DOTHS)
