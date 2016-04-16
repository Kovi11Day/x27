%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "struct_tree.h"
#include "web_compiler.tab.h"
  int fileno(FILE*);
%}
%x ATTRIBUT
%x TEXT_MODE_1
%x TEXT_MODE_2


%option noinput nounput

IDEN [A-Za-z_][A-Za-z0-9_]*
NB ([[:digit:]]+(\.[[:digit:]]*)?)|(\.[[:digit:]]+)
XML [xX][mM][lL]
 //SAUF_XML  
KEY [[:alpha:]]+\=\"
 //TAG 
%%


fun {return FUN;}
rec {return REC;}
let {return LET;}
if  {return IF;}
where {return WHERE;}
in  {return IN;}
num {return NUM;}
then {return THEN;}
else {return ELSE;}
with {return WITH;}
match {return MATCH;}
     


{IDEN} {yyval.name=strdup(yytext);
  return IDEN;}

{NB }{yyval.value=atof(yytext);
return NUM;}

//{XML} printf(yytext);}// {return XML;}

[< > >= =< == . , ;  ] {return *yytext;}
[+ * ( ) \- / \% \*\*|\^] {return *yytext;}
     
\" {BEGIN TEXT_MODE_1;}

<TEXT_MODE_1>\" {BEGIN INITIAL;}

<TEXT_MODE_1>(.|\n) {
  yylval.name = strdup(yytext);
  return TEXT;
 }
{KEY} {ECHO;BEGIN TEXT_MODE_2;}

 <TEXT_MODE_2>\" {ECHO;BEGIN INITIAL;}

<TEXT_MODE_2>. {
  yylval.name = strdup(yytext);
  return VALUE;
 }
   
      
\[ {BEGIN <ATTRIBUT>;}

<ATTRIBUT>{KEY} {yylval.name = strdup(yytext)
     return KEY;
  BEGIN TEXT_MODE_2;
 }
<ATTRIBUT>\] {BEGIN INITIAL;}


{TAG}\{ {return TAG; BEGIN TEXT_MODE_1;}
{TAG}\[ {return TAG; BEGIN ATTRIBUT;}
{TAG}\/ {yylval.name = strdup(yytext);
  return EMPTY_NODE;}
\{\}  {}
\{\{* {printf("\{");}
\}\}* {printf("\}");}
\}    {return CLOSE;}
\{\"  {BEGIN TEXT_MODE_1;}
\]\/ {return EMPTY_NODE;}
