/*
 * cctab.c
 *
 * THIS FILE IS AUTOMATICALLY GENERATED.  DO NOT EDIT.
 */

#define E_NEEDS_STDIO_ONLY
#include "system.h"
#include "assert.h"
#include "cctab.h"

CCallDescriptor EMSTREAM_table[] = { 
  { (ccallFunction) streamOpen, "EMS_OPEN", "ixS" },
  { (ccallFunction) streamClose, "EMS_CLOSE", "vxi" },
  { (ccallFunction) streamEos, "EMS_EOS", "bxi" },
  { (ccallFunction) streamIsAtty, "EMS_ISATTY", "bxi" },
  { (ccallFunction) streamGetChar, "EMS_GETC", "cxi" },
  { (ccallFunction) streamUngetChar, "EMS_UNGETC", "vxic" },
  { (ccallFunction) streamGetString, "EMS_GETS", "Sxi" },
  { (ccallFunction) streamFillVector, "EMS_FILLV", "ixip" },
  { (ccallFunction) streamPutChar, "EMS_PUTC", "vxic" },
  { (ccallFunction) streamPutInt, "EMS_PUTI", "vxiii" },
  { (ccallFunction) streamWriteInt, "EMS_WRITEI", "vxiii" },
  { (ccallFunction) streamPutReal, "EMS_PUTF", "vxif" },
  { (ccallFunction) streamPutString, "EMS_PUTS", "vxip" },
  { (ccallFunction) streamFlush, "EMS_FLUSH", "vxi" },
  { (ccallFunction) streamBind, "EMS_BIND", "iS" },
  { (ccallFunction) streamAccept, "EMS_ACCEPT", "ii" },
  { (ccallFunction) streamRawRead, "EMS_RAWREAD", "ixip" },
};
CCallDescriptor STRING_table[] = { 
  { (ccallFunction) charIsAlpha, "EMCH_ISALPHA", "bi" },
  { (ccallFunction) charIsUpper, "EMCH_ISUPPER", "bi" },
  { (ccallFunction) charIsLower, "EMCH_ISLOWER", "bi" },
  { (ccallFunction) charIsDigit, "EMCH_ISDIGIT", "bi" },
  { (ccallFunction) charIsXdigit, "EMCH_ISXDIGIT", "bi" },
  { (ccallFunction) charIsAlnum, "EMCH_ISALNUM", "bi" },
  { (ccallFunction) charIsSpace, "EMCH_ISSPACE", "bi" },
  { (ccallFunction) charIsPunct, "EMCH_ISPUNCT", "bi" },
  { (ccallFunction) charIsPrint, "EMCH_ISPRINT", "bi" },
  { (ccallFunction) charIsGraph, "EMCH_ISGRAPH", "bi" },
  { (ccallFunction) charIsCntrl, "EMCH_ISCNTRL", "bi" },
  { (ccallFunction) charToUpper, "EMCH_TOUPPER", "ii" },
  { (ccallFunction) charToLower, "EMCH_TOLOWER", "ii" },
  { (ccallFunction) stringIndex, "EMST_INDEX", "ipi" },
  { (ccallFunction) stringRIndex, "EMST_RINDEX", "ipi" },
  { (ccallFunction) stringSpan, "EMST_SPAN", "ipp" },
  { (ccallFunction) stringCSpan, "EMST_CSPAN", "ipp" },
  { (ccallFunction) stringStr, "EMST_STR", "ipp" },
};
CCallDescriptor RAND_table[] = { 
  { (ccallFunction) xrandom, "RANDOM", "i" },
  { (ccallFunction) xsrandom, "SRANDOM", "vi" },
};
CCallDescriptor MISK_table[] = { 
  { (ccallFunction) die, "UEXIT", "vi" },
  { (ccallFunction) mgetenv, "UGETENV", "sS" },
  { (ccallFunction) opendir, "UOPENDIR", "pS" },
  { (ccallFunction) mreaddir, "UREADDIR", "sp" },
  { (ccallFunction) closedir, "UCLOSEDIR", "vp" },
};
CCallDescriptor *ccalltable[] = {
  EMSTREAM_table,
  STRING_table,
  RAND_table,
  MISK_table,
};
