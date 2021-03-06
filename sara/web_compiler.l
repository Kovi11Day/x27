%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
  //#include "struct_tree.h"
  //#include "web_compiler.tab.h"
int fileno(FILE*);
%}

%x ATTRIBUT
%x TEXT_MODE_1
%x TEXT_MODE_2

%option noinput nounput
IDEN [A-Za-z_][A-Za-z0-9_]*
NB ([[:digit:]]+(\.[[:digit:]]*)?)|(\.[[:digit:]]+)
XML [xX][mM][lL]
SAUF_XML [^{XML}[:^space:]]
TAG [{SAUF_XML}+[A-Za-z0-9]*\.\_\']+|[\_[A-Za-z0-9]*\.\_\']+
KEY [{SAUF_XML}+[A-Za-z0-9]*\.\_\']+|[\_[A-Za-z0-9]*\.\_\']+
%%
  
fun {printf("FUN");}
rec {printf("REC");}
let {printf("LET");}
"if" {printf("IF");}
where {printf("WHERE");}
in {printf("IN");}
num {printf("NUM");}
then {printf("THEN");}
"else" {printf("ELSE");}
with {printf("WITH");}
match {printf("MATCH");}

{IDEN} {
  printf("IDEN\n");
}

{NB} {printf("NUM\n");}

{TAG}"{" {printf("TAG\n");}

{TAG}"[" {printf("TAG\n");
  BEGIN ATTRIBUT;}

{TAG}"/" {
  printf("EMPTY_NODE\n");
     }

[<>=,;] {ECHO;}
[+*()\-/\%\*\*|\^] {ECHO;}
     
\" {BEGIN TEXT_MODE_1;}

<TEXT_MODE_1>\" {BEGIN INITIAL;}

<TEXT_MODE_1>[^\"]+ {
  printf("TEXT\n");
}

"[" {BEGIN ATTRIBUT;}

<ATTRIBUT>{KEY} {
  printf("KEY\n");
}
<ATTRIBUT>\" {BEGIN TEXT_MODE_2;}
<ATTRIBUT>[ =] {;}
<ATTRIBUT>"]" {BEGIN INITIAL;}
<ATTRIBUT>"]/" {
  printf("EMPTY_NODE\n");
  BEGIN INITIAL;
}

<TEXT_MODE_2>\" {BEGIN ATTRIBUT;}

<TEXT_MODE_2>[^\"]+ {
  printf("VALUE\n");
}
   
"}" {printf("CLOSE\n");}

.|\n {;}
  
%%

int main (void)
{
  yylex();
  return 0;
}
