%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  
  int yylex(void);
  void yyerror(char*);

%}
//grammaire pour construire arbre + attributs
%token KEY VALUE TAG CLOSE TEXT
%%

arbre: balise chaine CLOSE

chaine: chaine arbre
|chaine texte
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
