#include "empty.desc_i.h"
#include <stdlib.h>
#ifndef FILE
#include <stdio.h>
#endif
void disassemble(unsigned int ptr, int len, FILE *f);
long long totalbytecodes;
#ifdef PROFILEINTERPRET
int bc_freq[NINSTRUCTIONS];
#endif
int traceinterpret = 0;

int interpret(State *state)
{
  u32 pc;
  long long addtototalbytecodes = 0;
  unsigned char opcode;
#if defined(INTERPRETERLOCALS)
  INTERPRETERLOCALS
#endif
  UNSYNCH();
  while (1) {
    TOPOFTHEINTERPRETLOOP
#if defined(COUNTBYTECODES) || defined(PROFILEINTERPRET)
    addtototalbytecodes++;
#endif
    IFETCH1(opcode);
#ifdef PROFILEINTERPRET
    bc_freq[opcode]++;
#endif
#ifndef NTRACE
    if (traceinterpret >= 1) {
      printf("Executing opcode ");
      disassemble(pc-1, 1, stdout);
    }
#endif

    switch(opcode) {
      default:
	fprintf(stderr, "Undefined bytecode %d\n", opcode);
        break;
    }
  }
}

struct ite {
  char *name; char *param; int val;
} IT[] = {
};

void disassemble(unsigned int ptr, int len, FILE *f)
{
  register struct ite *it;
  register unsigned int base = ptr, limit = ptr + len;
  register unsigned char opcode;
  int i, arg, arg2, arg3;
  short int sarg;

  while (ptr < limit) {
    if (len > 1) fprintf(f, "%4d:\t", ptr - base);
    opcode = *(unsigned char *)ptr++;
    if (opcode < (sizeof IT / sizeof(struct ite))) {
      it = &IT[opcode];
      fprintf(f, "%s\t", it->name);
      if (*it->param) {
	arg = 0;
	if (!strcmp(it->param, "u32")) {
	  UFETCH4(arg, ptr, 1);
	  fprintf(f, "%d (0x%08x)", arg, arg);
	} else if (!strcmp(it->param, "u16")) {
	  UFETCH2(arg, ptr, 1);
	  fprintf(f, "%d (0x%04x)", arg, arg);
	} else if (!strcmp(it->param, "s16")) {
	  UFETCH2(sarg, ptr, 1);
	  arg = sarg;
	  fprintf(f, "%d (0x%04x)", arg, arg);
	} else if (!strcmp(it->param, "u8") || !strcmp(it->param, "s8")) {
	  UFETCH1(arg, ptr, 1);
	  fprintf(f, "%d (0x%02x)", arg, arg);
	} else if (!strcmp(it->param, "u8u8")) {
	  UFETCH1(arg, ptr, 1);
	  UFETCH1(arg2, ptr, 1);
	  fprintf(f, "%d %d (0x%02x 0x%02x)", arg, arg2, arg, arg2);
	} else if (!strcmp(it->param, "u8u16")) {
	  UFETCH1(arg, ptr, 1);
	  UFETCH2(arg2, ptr, 1);
	  fprintf(f, "%d %d (0x%02x 0x%04x)", arg, arg2, arg, arg2);
	} else if (!strcmp(it->param, "case32")) {
	  UFETCH2(arg, ptr, 2);
	  UFETCH2(arg2, ptr, 2);
	  fprintf(f, "%d %d (0x%02x 0x%02x)\n", arg, arg2, arg, arg2);
	  for (i = arg; i <= arg2; i++) {
	    UFETCH2(arg3, ptr, 2);
	    fprintf(f, "\t  %d -> %d\n", i, arg3 + ptr - base);
	  }
	  UFETCH2(arg3, ptr, 2);
	  fprintf(f, "\t  else -> %d", arg3 + ptr - base);
	} else {
	  fprintf(f, "bad param \"%s\"", it->param);
	}
	if (opcode == CALLOID || opcode == CALLOIDS) {
	  fprintf(f, " %s", OperationName(arg));
	}
      }
      fprintf(f, "\n");
    } else {
      fprintf(f, "? %d '%c'\n", opcode, opcode);
    }
  }
}

void outputProfile(void)
{
#ifdef PROFILEINTERPRET
  int i, j, maxindex, max;
  for (i = 0; i < NINSTRUCTIONS; i++) {
    maxindex = 0; max = bc_freq[maxindex];
    for (j = 1; j < NINSTRUCTIONS; j++) {
      if (bc_freq[j] > max) {
	maxindex = j;
	max = bc_freq[maxindex];
      }
    }
    if (max <= 0) return;
    printf("%4d: %15s %8d   %5.2f\n", i, IT[maxindex].name, max,
      (double) max * 100 / totalbytecodes);
    bc_freq[maxindex] = -1;
  }
#endif
}
