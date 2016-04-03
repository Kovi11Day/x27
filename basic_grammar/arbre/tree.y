%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  
  int yylex(void);
  void yyerror(char*);

%}
//grammaire pour construire arbre + attributs + empty nodes
//0 conflits !!!
%token KEY VALUE TAG CLOSE TEXT EMPTY_NODE
%%

arbre: balise chaine CLOSE

chaine: chaine intermediaire
|
;

intermediaire: EMPTY_NODE
|texte
|arbre

texte: TEXT

balise: TAG
|TAG suite_cle_valeur

suite_cle_valeur: suite_cle_valeur KEY VALUE
|KEY VALUE

%%

int main(){
  yyparse();
  return 0;
 }
