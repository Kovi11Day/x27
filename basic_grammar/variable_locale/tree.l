%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tree.tab.h"
  int fileno(FILE*);
%}

%x TEXT_MODE
%option noinput nounput

%%

key {return KEY;}

value {return VALUE;}

[[:alpha:]]+ {
  return TAG;
}

"}" {return CLOSE;}

\" {BEGIN TEXT_MODE;}

<TEXT_MODE>\" {BEGIN INITIAL;}

<TEXT_MODE>[[:alpha:]]+ {
  return TEXT;
 }

.|\n {}

