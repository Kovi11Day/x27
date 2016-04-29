%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <math.h>
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
%token IF THEN ELSE
%token<ast> ARITH_EXPR
%token LET REC IN WHERE WITH EMITT OPEN_FOREST  
%token <value> S P T
%

%type<ast> balise texte intermediaire arbre chaine foret 
%type<ast> expression partial_declaration var_loc_in var_loc_where var_declaration doc final_doc

%left '+''-'
%left '*''/'
%right '^'
%%

vrai_final: final_doc 

final_doc: final_doc doc {
  //printf("final_doc--> final_doc doc\n");
  clos = process_content($2, storage_env);
  emit("test_emit.html", clos->value);
 }
|doc {
    printf("final_doc --> doc\n");
    clos = process_content($1, storage_env);
  emit("test_emit.html", clos->value);
    $$ = $1;
   }

doc: var_declaration {
  printf("doc--> var_declaration\n");
  clos = process_content($1, storage_env);
  emit("test_emit.html", clos->value);
  $$ = $1;
 }
|var_loc_in {
  root = $1;
 }
|var_loc_where {
  root = $1;
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
  //display_graph("gtree.gv",clos->value);
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

|IDEN {
  $$ = mk_var($1);
  printf("expression--> variable\n");
 }
;
//TO CHANGE
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
expression_arithmetique:     expression_arithmetique arith_expr		{$$ = mk_tree($2,1,1,0,NULL,NULL);}		
	|			
	;
arith_expr : arith_expr'+'T		//{ $$= $1 + $3;}	
|arith_expr'-'T 				//{ $$= $1 - $3;}
| T
;
T:
T'*'P 						//{ $$= $1 * $3;}
|T'/'P 						{ if($3 != 0){///$$= $1 / $3;}
							else {
								printf("le dénominateur ne doit pas étre null \n");
								return 0;}}		
|P	 							//{ $$ = $1;}
;
P:
S "**" P 					//{ $$= pow($1,$3);}	
|S	 						//{$$ = $1;}
| '-' P{
	$$ = (-$2) ;
	fprintf(stderr, "p -> -p\n");
	}
|'('arith_expr')'			//{$$ = mk_node($2);}
;
S:NB				//{$$= mk_integer($1);}
;

%%

int main(void){
  storage_env = initial_env;
  yyparse();
  
  return 0;
}
