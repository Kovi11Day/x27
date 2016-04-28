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
statement : '('if_statement')' 					 {$$=$2;}
|if_statement									 {$$=$1;}
;
if_statement:IF1 IDEN THEN1 if_statement		 {printf("%c",$4);} 		
| IF1 IDEN THEN1 state ELSE1 if_statement	  	 {printf("%c",$6);}
|ID											     {printf("%c",$1);}
;
state: IF1 IDEN  THEN1 state ELSE1 state	     {printf("%c",$6);}
|ID											     {printf("%c",$1);}
;
%%
