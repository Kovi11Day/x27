%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include"struct_tree.h"
//#include "web_compiler.tab.h"


int fileno(FILE*);
int ligne = 0;
//%option 8bit
//%option case-insensitive

%}
%x COMMENTAIRE
%x TEXT_MODE
%option noinput nounput

ID [A-Za-z_][A-Za-z0-9_]*
NB ([[:digit:]]+(\.[[:digit:]]*)?)|(\.[[:digit:]]+)
%%

"//" {BEGIN COMMENTAIRE;}
<COMMENTAIRE>"\n" {BEGIN INITIAL;}
<COMMENTAIRE>. {}


'div' {printf("div");}//{return DIV;}
"br" {printf(yytext);}

"char"	{printf(yytext);}
"int"	{printf(yytext);}
"float" {printf(yytext);}
"double" {printf(yytext);}
"bool"	 {printf(yytext);}
"struct" {printf(yytext);}
"enum"	 {printf(yytext);}
"include" {printf(yytext);}

{ID} {printf(yytext);}

{NB} {printf(yytext);}

[[:blank:]]*   {printf(" ");} /*supprimer tous les espaces et saut de ligne inutile*/




"{" {printf("{");}//{ return ACCO_OPEN;}

"}" {printf("}");}//{return ACCO_CLOSE;}
"[" {printf("[");}//{ return CRO_OPEN;}
"]" {printf("]");}//{ return CRO_CLOSE;}

"<" {printf("<");}//{return BALISE_OPEN;}
"\>" {printf(yytext);}//{return BALISE_CLOSE;}
'>' {printf(">");}//{return SUP;}
"=" {printf("=");}//{return EGAL;}
"#" {printf("#");}//{return DIEZ;}
"." {printf(".");}//{return POINT;}
"," {printf(",");}//{return VIRGUL;}


"*" {printf("*");}//{return ETOILE;}
"+" {printf("+");}
"-" {printf("_");}
"/" {printf("/");} //{ return SLASH;}
"%" {printf("%");} //{ return SLASH;}
\*\* | \^ {printf(yytext);}
';' {printf(";");}//{return POINT VIRGULE;}



\" {BEGIN TEXT_MODE; {printf(yytext);}}

<TEXT_MODE>\" {BEGIN INITIAL;printf(yytext);}

<TEXT_MODE>[[:alpha:]]+ {
printf(yytext);
  //yylval.name = strdup(yytext);
  //return TEXT;
 }

.|\n {printf(yytext);}

