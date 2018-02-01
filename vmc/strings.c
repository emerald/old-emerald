#include <stdio.h>    /* sprintf */
#include <stdlib.h>   /* malloc */
#include <string.h>   /* strlen */

char *
replaceSuffix(
  char *filename,
  char *oldsx,
  char *newsx)
{
  int flen = 0, olen = 0, nlen = 0, i = 0;
  char *answer = 0;

  if (oldsx == 0) oldsx = "";
  if (newsx == 0) newsx = "";

  flen = strlen(filename);
  olen = strlen(oldsx);
  nlen = strlen(newsx);

  i = flen - olen;
  if (i > 0 && filename[i-1] != '/' && !strncmp(&filename[i], oldsx, olen)) {
    flen -= olen;
  }
  answer = malloc(flen + nlen + 1);
  sprintf(answer, "%.*s%s", flen, filename, newsx);
  return answer;
}

char *
findFileName(
  char *name)
{
  char *answer = 0;
  int i = 0;

  for (i = strlen(name)-1; i >= 0; i--) {
    if (name[i] == '/') break;
  }
  answer = malloc(strlen(name) - i + 1);
  sprintf(answer, "%s", &name[i+1]);
  return answer;
}
