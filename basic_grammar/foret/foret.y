%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  
  int yylex(void);
  void yyerror(char*);

%}
//grammaire present SANS CONFLITS
//grammaire pour construire arbre + attributs + empty nodes + var
//forets ok
%token KEY VALUE TAG OPEN CLOSE TEXT EMPTY_NODE
%token ARITH_EXPR
%token LET IDEN REC IN WHERE
%%


///////////////////////FORET////////////////////////////////////////////////////

 //foret_imbriquer: OPEN suite_inter_foret CLOSE
e: p
|e p
;

p: OPEN p CLOSE
|suite_inter_foret
;

suite_inter_foret: suite_inter_foret interieure_foret
|interieure_foret
;

interieure_foret: foret_simple
|arbre;
;

foret_simple: OPEN suite_arbres CLOSE
|OPEN CLOSE
;

suite_arbres: suite_arbres arbre
|arbre 
;

///////////////////////ARBRE////////////////////////////////////////////////////
arbre: balise chaine CLOSE //join_parent_daughters

chaine: chaine intermediaire //add_sibling
|
;

intermediaire: EMPTY_NODE //$$=create_empty_tree($1);
|texte //$$=$1;
|arbre //<tree>$$=$1;
	       //|declarations
|IDEN //$$=getvar($1)
;     

texte: TEXT //<tree>$$ = create_tree_text($1);

balise: TAG //<tree>$$= create_tree($1);
|TAG suite_cle_valeur //$$=create_tree_with_attributes($1, $2);

suite_cle_valeur: suite_cle_valeur KEY VALUE //<Attributs>$$=add_cle_valeur($1, $2, $3);
|KEY VALUE //$$ = create_attributes($1, $2);
;

%%

int main(void){
  yyparse();
  return 0;
 }
