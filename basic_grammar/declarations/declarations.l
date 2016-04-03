%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "declarations.tab.h"
  int fileno(FILE*);
%}

%x TEXT_MODE
%option noinput nounput

%%

arith {return ARITH_EXPR;}

let {return LET;}

rec {return REC;}

identificateur {return IDEN;}

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

