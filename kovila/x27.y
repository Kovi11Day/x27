%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include "import.h"
  #include "ast.h"
  //#include "var_storage.h"
  //#include "additional_ast.h"
  int yylex(void);
  void yyerror(char*);
  struct ast* root;
  struct env* storage_env;
  struct closure* clos;
%}

%union{
  char* name;
  int value;
  struct ast* ast;
  struct attributes* attr;
 }
%token<name> KEY VALUE TAG TEXT IDEN EMPTY_NODE
%token<attr> ATTR_FOUND
%token OPEN CLOSE NUM
%token IF CONDITION THEN ELSE
%token<ast> ARITH_EXPR
%token LET REC IN WHERE WITH

%type<ast> balise texte intermediaire arbre chaine foret
%type<ast> expression partial_declaration var_loc_in var_loc_where 

%left '+''-'
%left '*''/'
%right '^'
%%



doc: var_declaration
|var_loc_in {
  root = $1;
 }
|var_loc_where {
  root = $1;
 }
|expression
;
////////////////////////////CONDITIONS///////////////////////////////////////////////
/* expr_conditionelle: IF CONDITION THEN expr_conditionelle ELSE expr_conditionelle */
/* |IF CONDITION THEN expression ELSE expression */

////////////////////////////VARIABLES_LOCALES////////////////////////////////////////

var_loc_where: expression WHERE IDEN '=' var_loc_where{
  struct ast* fun_node = mk_fun($3, $1);
  struct ast* app_node = mk_app(fun_node, $5);
  $$ = app_node;
 }
|expression WHERE IDEN '=' var_loc_in{
  struct ast* fun_node = mk_fun($3, $1);
  struct ast* app_node = mk_app(fun_node, $5);
  $$ = app_node;
 }
|expression WHERE IDEN '=' expression{
  struct ast* fun_node = mk_fun($3, $1);
  struct ast* app_node = mk_app(fun_node, $5);
  $$ = app_node;
 }
;

var_loc_in: LET IDEN '=' expression IN var_loc_in{
  struct ast* fun_node = mk_fun($2, $6);
  struct ast* app_node = mk_app(fun_node, $4);
  $$ = app_node;
 }
| LET IDEN '=' expression IN expression{
  struct ast* fun_node = mk_fun($2, $6);
  struct ast* app_node = mk_app(fun_node, $4);
  $$ = app_node;
 }
;
/////////////////////////DECLARATION_VARIABLES///////////////////////////////////////


var_declaration: LET partial_declaration 

partial_declaration: IDEN '=' partial_declaration{
  /* variable new_var = create_variable ($1, $3); */
  /* add_variable(str, new_var); */
  storage_env = process_binding_instruction($1, $3, storage_env);
  $$ = $3;
}
| IDEN '=' expression ';' {
   /* variable new_var = create_variable($1, $3); */
   /* add_variable(str, new_var); */
  storage_env = process_binding_instruction($1, $3, storage_env);
  $$ = $3;
}
;
//expression---ajouter parantheses

expression: foret {$$ = $1; display_graph("gtree.gv",$1);  emit("test_emit.html", $1);}
| ARITH_EXPR {$$ = $1;} //TO CHANGE
//|expr_conditionelle

///////////////////////////////FORET/////////////////////////////////////////////////

foret: foret arbre {$$ = mk_forest(1, $1, $2);}
|arbre {
  $$ = mk_forest(0, $1, NULL);
  //clos = process_content($$, storage_env);
  
 }
|texte {$$ = mk_forest(0, $1, NULL);}
;
/////////////////////////////ARBRE///////////////////////////////////////////////////
arbre: balise chaine CLOSE {add_daughters($1, $2);}

chaine: chaine intermediaire {$$ = mk_forest(0, $1, $2);}
|intermediaire {$$ = $1;}
;

intermediaire: EMPTY_NODE {$$ = mk_tree($1, 1, 1, 0, NULL, NULL);}
|texte {$$ = $1;}
|arbre {$$ = $1;}
//|declarations
|IDEN {$$ = mk_var($1);}
;     

texte: TEXT {$$ = mk_word($1);}

balise: TAG {
  printf("mylabel is %s\n", $1);
  $$ = mk_tree($1, 1, 0, 0, NULL, NULL);}
|TAG ATTR_FOUND {
  printf("about to access attributes");
  $$ = mk_tree($1, 1, 0, 0, yylval.attr, NULL);}

//suite_cle_valeur = ATTR_FOUND
/* suite_cle_valeur: suite_cle_valeur KEY VALUE //{$$ = add_attribute($1, $2, $3);} */
/* |KEY VALUE //{$$ = create_attribute($1, $2);} */
/* ; */

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
