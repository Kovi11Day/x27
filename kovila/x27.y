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
%token <value> NUM
%token<name> IDEN
%token<attr> ATTR_FOUND
%token OPEN CLOSE  OPEN_FOREST
%token IF CONDITION THEN ELSE
%token<ast> ARITH_EXPR ARROW
%token LET REC IN WHERE WITH 
%token<name> TAG KEY VALUE TEXT EMPTY_NODE EMITT


%type<ast> expression partial_declaration var_loc_in var_loc_where var_declaration doc final_doc
%type<ast> foret statement if_statement 
%type<ast> arbre  
%type<ast> balise texte intermediaire chaine 



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

| EMITT doc{
//emit($1, $2);
  struct ast* app_node2 = mk_app(mk_binop(EMIT), mk_word($1));
  struct ast* app_node = mk_app(app_node2, $2);

  process_instruction(app_node, storage_env);
}
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
| statement
;


////////////////////////////CONDITIONS///////////////////////////////////////////////
/* expr_conditionelle: IF CONDITION THEN expr_conditionelle ELSE expr_conditionelle */
/* |IF CONDITION THEN expression ELSE expression */

statement : '(' if_statement ')'	{$$=$2;}			 
|if_statement   	{$$=$1;}	 
|IF NUM THEN expression ELSE expression {$$=mk_cond(mk_integer($2),$4,$6);}										

if_statement:  					
IF NUM THEN statement ELSE statement{
  $$=mk_cond(mk_integer($2),$4,$6);
}
;


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

chaine: intermediaire chaine {
  printf("chaine --> chaine intermediaire");
  $$ = mk_forest(false, $1, $2);}
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
;

/* //suite_cle_valeur '=' ATTR_FOUND */
/* suite_cle_valeur: suite_cle_valeur KEY VALUE //{$$ = add_attribute($1, $2, $3);} */
/* |KEY VALUE //{$$ = create_attribute($1, $2);} */
/* ; */

/////////////////////////////EXPR_ARITH////////////////////////////////////////////
/* /\* */

/* expression_arithmetique : expression_arithmetique E {$$=$2;} */
/* | */
/* ; */

/* E : E'+'E { $$=mk_app(mk_app(mk_binop(PLUS),$1),$3);} */
/* |E'-'E {$$=mk_app(mk_app(mk_binop(MINUS),$1),$3);} */
/* |E'*'E {$$=mk_app(mk_app(mk_binop(MULT),$1),$3);} */
/* |E'/'E {$$=mk_app(mk_app(mk_binop(DIV),$1),$3);} */
/* |NUM {$$= mk_integer($1);} */
/* ; */
/* *\/ */


%%

int main(void){
  storage_env = initial_env;
  yyparse();
  
  return 0;
}
