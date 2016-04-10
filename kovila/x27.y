%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  // #include "ast.h"
  #include "additional_ast.h"
  int yylex(void);
  void yyerror(char*);

%}

%union{
  char* name;
  int value;
  struct ast* ast;
  struct attributes* attr;
 }
%token<name> KEY VALUE TAG TEXT IDEN EMPTY_NODE
%token OPEN CLOSE NUM
%token<ast> ARITH_EXPR
%token LET REC IN WHERE

%type<attr> suite_cle_valeur
%type<ast> balise texte intermediaire arbre chaine foret
%type<ast> expression

%left '+''-'
%left '*''/'
%right '^'
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

expression: foret {$$ = $1;}
| ARITH_EXPR {$$ = $1;} //TO CHANGE
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
  yyparse();
  return 0;
}
