%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "struct_tree.h"
#include "x33.tab.h"
  int fileno(FILE*);
%}

%x TEXT_MODE
%option noinput nounput

%%

[[:alpha:]]+"{" {
  yylval.name = strdup(yytext);
  return TAG;
 }

"}" {return CLOSE;}

\" {BEGIN TEXT_MODE;}

<TEXT_MODE>\" {BEGIN INITIAL;}

<TEXT_MODE>[[:alpha:]]+ {
  yylval.name = strdup(yytext);
  return TEXT;
 }

.|"\n" {}

