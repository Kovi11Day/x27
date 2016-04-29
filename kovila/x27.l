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

%x STD_TAG_MODE

%option noinput nounput

IDEN [A-Za-z_][A-Za-z0-9_]*
NB ([[:digit:]]+(\.[[:digit:]]*)?)|(\.[[:digit:]]+)
XML_space [[:space:]]*[xX][[:space:]]*[mM][[:space:]]*[lL][[:space:]]*
TAG (\_?[[:alnum:]]+(\.|\'|\_)*)+
KEY (\_?[[:alnum:]]+(\.|\'|\_)*)+
  
%%
  
fun {printf("FUN");return FUN;}
rec {printf("REC");return REC;}
let {printf("LET");return LET;}
"if" {printf("IF");return IF;}
where {printf("WHERE");return WHERE;}
in {printf("IN");return IN;}
num {printf("NUM");return NUM;}
then {printf("THEN");return THEN;} 
"else" {printf("ELSE");return ELSE;}
with {printf("WITH");return WITH;}
match {printf("MATCH");return MATCH;}


{TAG} {
  printf("tag found\n");
  yylval.name = strdup(yytext);
  BEGIN STD_TAG_MODE;
}

{IDEN} {  yylval.name=strdup(yytext);
  return IDEN;
  printf("IDEN\n");
}

{NB} {
  yylval.value=atof(yytext);
  return NUM;
  printf("NUM\n");
}

{XML_space}{TAG} {fprintf(stderr, "erreur de syntaxe:TAG illicite\n"); return 1;}



<STD_TAG_MODE>"{" {
  printf("sending tag\n");
  BEGIN INITIAL;
  return TAG;
}

<STD_TAG_MODE>"[" {
  printf("tag has attributes\n");
  yylval.attr=create_attribute(NULL,NULL);
  last_attr=yylval.attr;
  BEGIN ATTRIBUT;
  //return TAG;
 }

<ATTRIBUT>{KEY} {
  last_attr = add_key_to_attr(last_attr,strdup(yytext));
  printf("KEY\n");
}

<ATTRIBUT>\" {printf("txt_mode2\n");BEGIN TEXT_MODE_2;}

<ATTRIBUT>[ =] {;}

<ATTRIBUT>"]" {BEGIN INITIAL;return ATTR_FOUND;}

{TAG}"/" {
  yylval.name = strdup(yytext);
  printf("EMPTY_NODE\n");
  return EMPTY_NODE;
     }

<TEXT_MODE_2>\" {BEGIN ATTRIBUT;}

<TEXT_MODE_2>[^\"]+ {
  last_attr=add_val_to_attr(last_attr,strdup(yytext));
  printf("VALUE\n");
}

 "/" {return EMPTY_NODE;}

[<>=,;] {return *yytext;}

[+*()\-/\%\*\*|\^] {return *yytext;}
     
\" {BEGIN TEXT_MODE_1;}

<TEXT_MODE_1>\" {BEGIN INITIAL;}

<TEXT_MODE_1>[^\"]+ {
  yylval.name=strdup(yytext);
  printf("TEXT\n");
  return TEXT;
 }



  
"}" {printf("CLOSE\n"); return CLOSE;}

.|\n {;}
  
%%

