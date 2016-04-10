%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "additional_ast.h"
#include "x27.tab.h"
  int fileno(FILE*);
%}

%x TEXT_MODE
%option noinput nounput

%%
[[:digit:]]+					|
[[:digit:]]*"."[[:digit:]]+ 	|
[[:digit:]]+"."[[:digit:]]* 	{
  //yylval.real = atof(yytext);
	return NUM;
 }

[=;+*^%/\-] {return *yytext;}

in {return IN;}

where {return WHERE;}

arith {return ARITH_EXPR;}

let {return LET;}

rec {return REC;}

key {return KEY; yylval.name=strdup(yytext);}

value {return VALUE; yylval.name=strdup(yytext);}

"<br/>" {return EMPTY_NODE;}

[[:alpha:]]+ {return IDEN;}
[[:alpha:]]+"{" {return TAG; yylval.name = strdup(yytext);}

"{" {return OPEN;}

"}" {return CLOSE;}

\" {BEGIN TEXT_MODE;}

<TEXT_MODE>\" {BEGIN INITIAL;}

<TEXT_MODE>[[:alpha:]]+ {
  return TEXT;
 }

.|\n {}

