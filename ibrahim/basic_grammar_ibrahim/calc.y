%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
	int i;
  int yylex(void);
  void yyerror(char*);
	
%}

%token IF1 THEN1 ELSE1
%token IDEN ID

%%
fin: calcule'\n' {return 0;}
calcule : calcule statement   {i++;printf("Résultat de l'opération n°%d : %c \n",i,$2);}
|  
;
statement : '('if_statement')' 					 {$$=$2;}
|if_statement									 {$$=$1;}
|ID												 {$$=$1;}						
;
if_statement:  					
IF1 IDEN THEN1 statement  ELSE1 statement		  	 {printf("%c",$6);}
;

%%
