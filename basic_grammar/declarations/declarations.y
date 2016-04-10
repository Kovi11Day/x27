%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  
  int yylex(void);
  void yyerror(char*);

%}
//grammaire present SANS CONFLITS
//grammaire pour construire arbre + attributs + empty nodes + var
//grammaire pour dec, var_locales 
%token KEY VALUE TAG OPEN CLOSE TEXT EMPTY_NODE
%token ARITH_EXPR
%token LET IDEN REC IN WHERE
%%

doc: declaration_var
|var_loc_in
|var_loc_where
;
////////////////////////////VARIABLES_LOCALES////////////////////////////////////////

var_loc_where: var_loc_where WHERE affectation
|expression WHERE affectation
|var_loc_in WHERE affectation
;

var_loc_in: LET affectation IN var_loc_in
| LET affectation IN expression
;

/////////////////////////DECLARATION_VARIABLES///////////////////////////////////////

declaration_var: LET affectation ';'

affectation: IDEN '=' affectation
|expression//<expression>$$ = $1; add_var_in_storage(s,$1,$3);
	     //|garbre
;
 //expression---ajouter parantheses

expression: foret//$$=creeer_expr_tree();
| ARITH_EXPR //<Expression>$$=creer_expression_arith();
;


///////////////////////////////FORET///////////////////////////////////////////////////
foret: foret arbre
|arbre
|texte
;
/////////////////////////////ARBRE///////////////////////////////////////////////////
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
