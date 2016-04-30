%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//#include "additional_ast.h"
#include "ast.h"
#include "x27.tab.h"
int fileno(FILE*);
struct attributes* last_attr = NULL;
%}

%x ATTRIBUT
%x TEXT_MODE_1
%x TEXT_MODE_2
%x TAG_MODE
%x TAG_TYPE_MODE
%x MODE_EMIT
%x MODE_INSIDE_EMIT

%option noinput nounput

IDEN [A-Za-z_][A-Za-z0-9_]*
NB ([[:digit:]]+(\.[[:digit:]]*)?)|(\.[[:digit:]]+)
XML_space [[:space:]]*[xX][[:space:]]*[mM][[:space:]]*[lL][[:space:]]*
TAG (\_?[[:alnum:]]+(\.|\'|\_)*)+
TAG_ATRIBUTE (\_?[[:alnum:]]+(\.|\'|\_)*)+
KEY (\_?[[:alnum:]]+(\.|\'|\_)*)+
  
%%
  
fun {printf("FUN\n"); return FUN;}
rec {printf("REC\n"); return REC; }
let {printf("LET\n"); return LET;}
"if" {printf("IF\n"); return IF;}
where {printf("WHERE\n"); return WHERE;}
in {printf("IN\n"); return IN;}
num {printf("NUM\n"); return NUM;}
then {printf("THEN\n"); return THEN;}
"else" {printf("ELSE\n"); return ELSE;}
with {printf("WITH\n"); return WITH;}
match {printf("MATCH\n"); return MATCH;}

emit {BEGIN MODE_EMIT;}

<MODE_EMIT>\" {BEGIN MODE_INSIDE_EMIT;}

<MODE_INSIDE_EMIT>{TAG}\."html" {
  yylval.name=strdup(yytext);
  printf("EMIT\n");
  return EMITT;
 }


{NB} {return NUM;}

{XML_space}{TAG} {fprintf(stderr, "erreur de syntaxe:TAG illicite\n"); return 1;}

({TAG}"/")|({TAG}"{")|({TAG}"[") {
  //printf("tag first time round\n");
  //printf("tag_content:%s\n",yytext);
  yyless(0);
  BEGIN TAG_MODE;
   //REJECT;
}

{TAG} {
  printf("IDEN\n");
  yylval.name=strdup(yytext);
  return IDEN;
}

<TAG_MODE>{TAG} {
  //printf("tag first second round\n");
  //printf("content:%s\n",yytext);
  yylval.name = strdup(yytext);
  BEGIN TAG_TYPE_MODE;
 }

<TAG_TYPE_MODE>"/" {
  printf("EMPTY_NODE\n");
  BEGIN INITIAL;
  return EMPTY_NODE;
 }

<TAG_TYPE_MODE>"{" {
  printf("TAG\n");
  BEGIN INITIAL;
  return TAG;
 }

<TAG_TYPE_MODE>"[" {
  printf("TAG_ATTR\n");
  //yylval.attr=create_attribute(NULL,NULL);
  //last_attr=yylval.attr;
  BEGIN ATTRIBUT;
 }


[<>;,=] {
  printf("%s\n", yytext);
  return yytext[0];}
[+*()\-/\%\*\*|\^] {return *yytext;}
     
\" {BEGIN TEXT_MODE_1;}

<TEXT_MODE_1>\" {BEGIN INITIAL;}
<TEXT_MODE_1>[^\"]+ {
  yylval.name=strdup(yytext);
  printf("TEXT\n");
  return TEXT;
 }


<ATTRIBUT>{KEY} {
  //last_attr = add_key_to_attr(last_attr,yytext);
  printf("KEY\n");
}
<ATTRIBUT>\" {BEGIN TEXT_MODE_2;}
<ATTRIBUT>[ =] {;}
<ATTRIBUT>"]" {BEGIN INITIAL; return ATTR_FOUND;}
 
<TEXT_MODE_2>\" {BEGIN ATTRIBUT;}

<TEXT_MODE_2>[^\"]+ {
  //last_attr=add_val_to_attr(last_attr,yytext);
  printf("VALUE\n");
}

"{" {printf("OPEN_FOREST\n");
  return OPEN_FOREST;
}

"}" {
  printf("CLOSE\n");
  return CLOSE;
}
.|\n {;}
 
%%

