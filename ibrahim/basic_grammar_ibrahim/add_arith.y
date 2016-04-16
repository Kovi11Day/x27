%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  
  int yylex(void);
  void yyerror(char*);

%}
%union {
		double real;
		char* var;
		}
%token <real> NBR
%token <var> ID
%token PUISSANCE SUM
%type <real> e t s p

//grammaire present SANS CONFLITS
//grammaire pour construire arbre + attributs + empty nodes + var
//grammaire pour dec, var_locales 
%token KEY VALUE TAG CLOSE TEXT EMPTY_NODE
%token if then else
%token LET IDEN REC IN WHERE 
%token <real> NUM 
%token <real> EXPR   other
%token PUIS
%type <real>  stmt matched unmatched  	
%right PUISSANCE  
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
	
fin: calcule'\n' 			////{return 0;}
calcule : calcule e ';'  	///{i++;printf("Résultat de l'opération n°%d : %f \n",i,$2);}
|  
;

e : e'+'t   					 ///{ $$= $1 + $3;}	
|	 e'-'t 						////{ $$= $1 - $3;}

			
| 	t 							///{$$ = $1;}
;

t : t'*'p 						/////{ $$= $1 * $3;}

|	t'/'p 						////{ if($3 != 0){
								///$$= $1 / $3;}
								/////else {
								/////	printf("le dénominateur ne doit pas étre null \n");
								/////		return 0;}
		}		
|	p 								/////{ $$ = $1;}
;

p: 	s PUISSANCE p 							 //////{ $$= pow($1,$3);}	
| s 											//////{ $$ = $1;}
| '-' p {
	$$ = (-$2) ;
	fprintf(stderr, "p -> -p\n");
	}
|'('e')' 									///////{$$ = ($2) ;}
;

s: NBR										//////{ $$= $1;}
;

///////////////////////////////////IF THEN ELSE  Conditional ////////////////////////////////////////////////////////

e:  e stmt
	|
	;

stmt:
	matched
|	unmatched
;
matched: if EXPR then matched else matched           
|		 other									
|		'('matched')'								
;		
unmatched: if EXPR then stmt							
|			if EXPR then matched else unmatched 		
|			'('unmatched')'								
;

//////////////////////Function/////////////////////

result :			'('f argument')'
;

affect:
					'('result other')'
|					'('affect other')'
|			   		final
;
///////////////////////////////////////////////



%%

int main(void){
  yyparse();
  return 0;
 }
