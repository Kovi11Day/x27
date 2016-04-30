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
%token<name> IDEN
%token<attr> ATTR_FOUND
%token OPEN CLOSE NUM OPEN_FOREST
%token IF CONDITION THEN ELSE
%token<ast> ARITH_EXPR
%token LET REC IN WHERE WITH 
%token<name> TAG KEY VALUE TEXT EMPTY_NODE EMITT


%type<ast> expression partial_declaration var_loc_in var_loc_where var_declaration doc final_doc
%type<ast> foret
%type<ast> arbre  
%type<ast> balise texte intermediaire chaine
%type<ast> statement if_statement


%left '+''-'
%left '*''/'
%right '^'
%%

vrai_final: final_doc {printf("vrai_doc--> final_doc doc\n");}

final_doc: final_doc doc {
  printf("final_doc--> final_doc doc\n");
  printf("PROCESS CONTENT\n");
  clos = process_content($2, storage_env);
  printf("OKAYYYY\n");
  emit("test_emit.html", clos->value);
  //$$ = $2;
 }
|doc {
  printf("final_doc --> doc\n");
  printf("PROCESS CONTENT\n");
  clos = process_content($1, storage_env);
  printf("OKAYYY\n");
  emit("test_emit.html", clos->value);
  //$$ = $1;
 }
| statement
//| EMITT expression{
//emit($1, $2);
  /* struct ast* app_node = mk_app(emit, mk_word($2)); */
  /* struct ast* app_node2 = mk_app(app_node, $3); */
  /* process_instruction(app_node2, storage_env); */
//}
;

doc: var_declaration {
  printf("doc --> var_declaration\n");
  $$ = $1;
 }
|var_loc_in {
  $$ = $1;
 }
|var_loc_where {
  $$ = $1;
 }
|expression {
  printf("doc --> expression \n");
  $$ = $1;
 }

;
////////////////////////////CONDITIONS///////////////////////////////////////////////
/* expr_conditionelle: IF CONDITION THEN expr_conditionelle ELSE expr_conditionelle */
/* |IF CONDITION THEN expression ELSE expression */

statement : '('if_statement')'	{$$=$2;}			 
|if_statement					{$$=$1;}	 
|expression 					{$$=$1;}										
;
if_statement:  					
IF expression THEN statement  ELSE statement{
$$=mk_cond($2,$4,$6);
}		  	


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


var_declaration: LET partial_declaration{
  $$ = $2;
  printf("var_declaration --> LET partial_declaration\n");
 } 

partial_declaration: IDEN '=' partial_declaration{
    printf("partial_declaration --> IDEN '=' partial_declaration\n");
  /* variable new_var = create_variable ($1, $3); */
  /* add_variable(str, new_var); */
  storage_env = process_binding_instruction($1, $3, storage_env);
  $$ = $3;
}
| IDEN '=' expression ';' {
  printf ("partial_declaration --> IDEN '=' expression ';' \n");
   /* variable new_var = create_variable($1, $3); */
   /* add_variable(str, new_var); */
  storage_env = process_binding_instruction($1, $3, storage_env);
  $$ = $3;
}
;

//expression---ajouter parantheses

expression: foret {
  printf("expression--> foret\n");
  $$ = $1; }

| ARITH_EXPR {$$ = $1;}

/* |IDEN ','{ */
/*   $$ = mk_var($1); */
/*   printf("expression--> variable\n"); */
/*  } */
;
//TO CHANGE
//|expr_conditionelle

///////////////////////////////FORET/////////////////////////////////////////////////

foret: OPEN_FOREST foret arbre CLOSE {
  printf("foret ->  OPEN_FOREST foret arbre CLOSE\n");
  $$ = mk_forest(false, $2, $3);
 }
|arbre {
  //$$ = mk_forest(0, $1, NULL);
  $$ = $1;
 }
//|texte {$$ = mk_forest(0, $1, NULL);}
//|OPEN_FOREST CLOSE {$$ = NULL;}
;
/////////////////////////////ARBRE///////////////////////////////////////////////////
arbre: balise chaine CLOSE { printf("arbre -> balise chaine CLOSE\n");
   $$ = add_daughters($1, $2);
 }
|IDEN ',' {$$ = mk_var($1);}

chaine: chaine intermediaire {
  printf("chaine --> chaine intermediaire");
  $$ = mk_forest(false, $2, $1);}
|intermediaire {
  printf("chaine --> intemediaire\n");
  $$ = mk_forest(false, $1, NULL);}
;

intermediaire: EMPTY_NODE {$$ = mk_tree($1, false, 1, false, NULL, NULL);}
|texte {$$ = $1;}
|arbre {$$ = $1;}
//|IDEN ',' {$$ = mk_var($1);}
;     

texte: TEXT {
  //$$ = mk_tree();
  $$ = mk_word($1);}

balise: TAG {
  printf("mylabel is %s\n", $1);
  $$ = mk_tree($1, false, false, false, NULL, NULL);}
|TAG ATTR_FOUND {
  printf("about to access attributes");
  $$ = mk_tree($1, false, false, false, yylval.attr, NULL);}

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
  storage_env = initial_env;
  yyparse();
  
  return 0;
}
