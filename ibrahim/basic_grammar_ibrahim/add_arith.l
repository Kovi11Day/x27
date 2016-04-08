%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "add_arith.tab.h"
  int fileno(FILE*);
  
%}
%x TEXT_MODE
%option noinput nounput

%%
[[:digit:]]+					|
[[:digit:]]*"."[[:digit:]]+ 	|
[[:digit:]]+"."[[:digit:]]* 	{
	yylval.real = atof(yytext);
	return NUM;
	}


"**"			return(PUIS);
[+\-*/%()=;] {return *yytext;}

in {return IN;}

where {return WHERE;}


let {return LET;}

rec {return REC;}

key {return KEY;}

value {return VALUE;}

"<br/>" {return EMPTY_NODE;}

[[:alpha:]]+ {return IDEN;}
[[:alpha:]]+"{" {return TAG;}

"}" {return CLOSE;}

\" {BEGIN TEXT_MODE;}

<TEXT_MODE>\" {BEGIN INITIAL;}

<TEXT_MODE>[[:alpha:]]+ {
  return TEXT;
 }

.|\n {}

