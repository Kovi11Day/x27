%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "calc.tab.h"
  int fileno(FILE*);
  
%}
%x TEXT_MODE
%option noinput nounput

%%
"("	{return ('(');}
")"	{return (')');}
"if" {return IF1;}
"then" {return THEN1;}
"else" {return ELSE1;}


[[:alpha:]]* {return IDEN;}
[[:alpha:]]* {return ID;}



.|\n {}



%%
