#include "one_state.desc.h"
#define UFETCH1(where,ptr,inc) { \
  where = *((unsigned char*)(ptr)); \
  if (inc) (ptr) = (int)(ptr) + 1; \
}
#define UFETCH2(where,ptr,inc) { \
  ptr = (((int)ptr + 1) & ~0x1); \
  where = (*((unsigned short*)ptr)); \
  if (inc) (ptr) = (int)(ptr) + 2; \
  where = ntohs(where); \
}

#define UFETCH4(where,ptr,inc) { \
  ptr = (((int)ptr + 3) & ~0x3); \
  where = (*((unsigned int*)ptr)); \
  if (inc) (ptr) = (int)(ptr) + 4; \
  where = ntohl(where); \
}



#define IFETCH1(where) UFETCH1(where, pc, 1)
#define IFETCH2(where) UFETCH2(where, pc, 1)
#define IFETCH4(where) UFETCH4(where, pc, 1)

#define PUSH(type,value) { \
  *(type *)sp = (value); \
  sp += sizeof(type); \
}
#define  POP(type,value) { \
  sp -= sizeof(type); \
  value = *(type *)sp; \
}
#define  TOP(type,value) { \
  value = *(type *)(sp - sizeof(type)); \
}
#define SETTOP(type,value) { \
  *(type *)(sp - sizeof(type)) = value; \
}
#define FETCH(type,base,offset) \
  (*(type*)((int)(base) + (int)(offset)))
#define STORE(type,base,offset,value) \
  (*(type*)((int)(base) + (int)(offset)) = (value))

typedef int s32;
typedef unsigned int u32;
typedef unsigned short u16;
typedef short s16;
typedef unsigned char u8;
typedef char s8;
typedef float f32;



#define NINSTRUCTIONS 0
typedef struct State {
  u32 firstThing;
  u32 pc;
  int a;		/* This is a */
} State;
#define F_SYNCH() (\
  state->a = a,\
  state->pc = pc)
#define F_UNSYNCH() (\
  a = state->a,\
  pc = state->pc )
#ifdef COUNTBYTECODES
#define SYNCH() (\
  F_SYNCH(),\
  totalbytecodes += addtototalbytecodes, \
  addtototalbytecodes = 0 )
#define UNSYNCH() (\
  F_UNSYNCH(),\
  addtototalbytecodes = 0 )
#else /* COUNTBYTECODES */
#define SYNCH() (\
  state->a = a,\
  state->pc = pc)
#define UNSYNCH() (\
  a = state->a,\
  pc = state->pc )
#endif
