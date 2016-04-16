%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "additional_ast.h"
#include "x27.tab.h"
  int fileno(FILE*);
%}

%x ATTRIBUT
%x TEXT_MODE_1
%x TEXT_MODE_2


%option noinput nounput

IDEN [A-Za-z_][A-Za-z0-9_]*
NB ([[:digit:]]+(\.[[:digit:]]*)?)|(\.[[:digit:]]+)
KEY [[:alpha:]]+\=\"
TAG ([[:alpha:]]+"{")|([[:alpha:]]+"{")
%%


fun {return FUN;}
rec {return REC;}
let {printf("msg from lex: LET found\n"); return LET;}
"if" {return IF;}
where {return WHERE;}
in  {return IN;}
num {return NUM;}
then {return THEN;}
"else" {return ELSE;}
match {return MATCH;}
     


{IDEN} {yylval.name=strdup(yytext);
  printf("msg from lex: IDEN found\n"); 
  return IDEN;}

{NB} {
  yylval.value=atof(yytext);
  return NUM;}

{TAG} {
  printf("msg from lex: TAG found\n"); 
  return TAG;
}

[>=<,;] {return *yytext;}
[+*( ) \- / \% \*\*|\^] {return *yytext;}
     
\" {BEGIN TEXT_MODE_1;}

<TEXT_MODE_1>\" {BEGIN INITIAL;}

<TEXT_MODE_1>(.|\n)+ {
  yylval.name = strdup(yytext);
  return TEXT;
}

 <TEXT_MODE_2>\" {BEGIN ATTRIBUT;}

<TEXT_MODE_2>(.|\n)+ {
  yylval.name = strdup(yytext);
  return VALUE;
}
   
\[ {BEGIN ATTRIBUT;}

<ATTRIBUT>{KEY} {
  yylval.name = strdup(yytext);
  return KEY;
  BEGIN TEXT_MODE_2;
}

<ATTRIBUT>"]" {BEGIN INITIAL;}

.|\n {;}
%%
