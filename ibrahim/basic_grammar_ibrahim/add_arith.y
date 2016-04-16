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
%type <real> E T S P

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
calcule : calcule E ';'  	///{i++;printf("Résultat de l'opération n°%d : %f \n",i,$2);}
|  
;

E : E'+'T   					 ///{ $$= $1 + $3;}	
| E'-'T 						////{ $$= $1 - $3;}

			
| T 							///{$$ = $1;}
;

T : T'*'P 						/////{ $$= $1 * $3;}

|T'/'P 						////{ if($3 != 0){
								///$$= $1 / $3;}
								/////else {
								/////	printf("le dénominateur ne doit pas étre null \n");
								/////		return 0;}
		}		
|	P 								/////{ $$ = $1;}
;

P: 	S PUISSANCE P 							 //////{ $$= pow($1,$3);}	
| S 											//////{ $$ = $1;}
| '-' P {
	$$ = (-$2) ;
	fprintf(stderr, "p -> -p\n");
	}
|'('E')' 									///////{$$ = ($2) ;}
;

S: NBR										//////{ $$= $1;}
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
