#ifndef semantic_h
#define semantic_h

void
installDefinition(
  char *code);

void
installInstruction(
  char *name,
  char *param,
  char *code,
  int lineno);

void
installInterrupt(
  char *name,
  char *code);

void
installState(
  char *name,
  char *desc,
  char *type);

void
yyerror(
  const char *s);

#endif // semantic_h
