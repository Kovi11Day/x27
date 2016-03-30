%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "struct_tree.h"
#include "web_compiler.tab.h"
  int fileno(FILE*);
%}

%x TEXT_MODE
%option noinput nounput
NB ([[:digit:]]+(\.[[:digit:]]*)?)|(\.[[:digit:]]+)
%%

[[:alpha:]]+ {
  yylval.name = strdup(yytext);
  return TAG;
}
{NB} { yyval.value=atof(yytext);
        return NUM;
         return ID;}

\+         return '+';
\*         return '*';
\(         return '(';
\)         return ')';
\-         return '-';
\/         return '/';
\%         return '%';
\*\*|\^    return POW;

"}" {return CLOSE;}

\" {BEGIN TEXT_MODE;}

<TEXT_MODE>\" {BEGIN INITIAL;}

<TEXT_MODE>[[:alpha:]]+ {
  yylval.name = strdup(yytext);
  return TEXT;
 }

.|\n {}

