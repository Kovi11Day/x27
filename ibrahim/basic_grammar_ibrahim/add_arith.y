%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  
  int yylex(void);
  void yyerror(char*);

%}
%union {
  double real;
}
//grammaire present SANS CONFLITS
//grammaire pour construire arbre + attributs + empty nodes + var
//grammaire pour dec, var_locales 
%token KEY VALUE TAG CLOSE TEXT EMPTY_NODE
%token if then else
%token LET IDEN REC IN WHERE 
%token <real> NUM 
%token <real> EXPR   other
%token PUIS
%type <real>  arith_expr stmt matched unmatched  	
%left '+''-'
%left '*''/'
%%

/////////////////////////////Forest///////////////////////////////////////////////////

expression: arbre//$$=creeer_expr_tree();
| arith_expr //<Expression>$$=creer_expression_arith();
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

/////////////////////////////Expresssion Arithme///////////////////////////////////////////////////	
s:	s arith_expr 		
	|			
	;	
 arith_expr:
        NUM 						   
|        arith_expr '+' arith_expr    
|        arith_expr '-'  arith_expr	    
|        arith_expr '*' arith_expr		
|        arith_expr'/' 	arith_expr	 	
|        arith_expr '%' arith_expr 		
|        arith_expr PUIS arith_expr  	
;
///////////////////////////////////IF THEN ELSE  Conditional ////////////////////////////////////////////////////////

e:  e stmt
	|
	;

stmt:
	matched
|	unmatched
;
matched: if EXPR then matched else matched           {printf("%s",$6);}
|		 other										{$$=$1;}
|		'('matched')'								{$$=$2;}
;		
unmatched: if EXPR then stmt							{printf("%s",$4);}
|			if EXPR then matched else unmatched 		{$$=$6;}
|			'('unmatched')'								{$$=$2;}
;


%%

int main(void){
  yyparse();
  return 0;
 }
