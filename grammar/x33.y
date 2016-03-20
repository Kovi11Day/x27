%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include "struct_tree.h"
  
  int yylex(void);
  void yyerror(char*);
  
%}

%union{
  char* name;
  double value;
  tree t;
 }

%token <name> TAG TEXT
%token CLOSE

%%

chaine: chaine arbre
|chaine TEXT
|TEXT
|arbre

arbre: TAG chaine CLOSE

%%

int main(){
  yyparse();
  return 0;
 }
