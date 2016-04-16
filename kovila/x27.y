%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  // #include "ast.h"
  #include "var_storage.h"
  //#include "additional_ast.h"
  int yylex(void);
  void yyerror(char*);
  storage str;
%}

%union{
  char* name;
  int value;
  struct ast* ast;
  struct attributes* attr;
 }
%token<name> KEY VALUE TAG TEXT IDEN EMPTY_NODE
%token OPEN CLOSE NUM
%token IF CONDITION THEN ELSE
%token<ast> ARITH_EXPR
%token LET REC IN WHERE

%type<attr> suite_cle_valeur
%type<ast> balise texte intermediaire arbre chaine foret
%type<ast> expression affectation

%left '+''-'
%left '*''/'
%right '^'
%%

doc: declaration_var
|var_loc_in
|var_loc_where
;
////////////////////////////CONDITIONS///////////////////////////////////////////////
/* expr_conditionelle: IF CONDITION THEN expr_conditionelle ELSE expr_conditionelle */
/* |IF CONDITION THEN expression ELSE expression */

////////////////////////////VARIABLES_LOCALES////////////////////////////////////////

var_loc_where: var_loc_where WHERE affectation
|expression WHERE affectation
	       //|var_loc_in WHERE affectation
;

var_loc_in: LET affectation IN var_loc_in
| LET affectation IN expression
;

/////////////////////////DECLARATION_VARIABLES///////////////////////////////////////

declaration_var: LET IDEN '=' expression ';'{
  variable new_var = create_variable($1, $3);
  add_variable(str, new_var);
  $$ = $3;
 }


/* affectation: IDEN '=' affectation { */

/*  } */
/* |expression {$$ = $1;} */
/* //|garbre */
/* ; */

//expression---ajouter parantheses

expression: foret {$$ = $1;}
| ARITH_EXPR {$$ = $1;} //TO CHANGE
//|expr_conditionelle
;
///////////////////////////////FORET/////////////////////////////////////////////////
foret: foret arbre {add_tree_to_forest($2, $1);}
|arbre {mk_forest(1, $1, $1);}
|texte  {mk_forest(1, $1, $1);}
;
/////////////////////////////ARBRE///////////////////////////////////////////////////
arbre: balise chaine CLOSE {join_to_parent($2, $1);}

chaine: chaine intermediaire {join_to_siblings($2, $1);}
|intermediaire {$$ = $1;}
;

intermediaire: EMPTY_NODE {$$ = mk_tree($1, 1, 1, 0, NULL, NULL);}
|texte {$$ = $1;}
|arbre {$$ = $1;}
//|declarations
|IDEN {$$ = mk_var($1);}
;     

texte: TEXT {$$ = mk_word($1);}

balise: TAG {$$ = mk_tree($1, 1, 0, 0, NULL, NULL);}
|TAG suite_cle_valeur {$$ = mk_tree($1, 1, 0, 0, $2, NULL);}

suite_cle_valeur: suite_cle_valeur KEY VALUE {$$ = add_attribute($1, $2, $3);}
|KEY VALUE {$$ = create_attribute($1, $2);}
;

/////////////////////////////EXPR_ARITH////////////////////////////////////////////
/*
expression_arithmetique:     expression_arithmetique arith_expr 		
	|			
	;

arith_expr:
NUM 						   
|        arith_expr '+' arith_expr    
|        arith_expr '-'  arith_expr	    
|        arith_expr '*' arith_expr		
|        arith_expr'/' 	arith_expr	 	
|        arith_expr '%' arith_expr 		
|        arith_expr '^' arith_expr  	
;
*/

%%

int main(void){
  str = create_storage();
  yyparse();
  destroy_storage(str);
  return 0;
}
