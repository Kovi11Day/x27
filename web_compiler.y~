%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include "struct_tree.h"
  
  int yylex(void);
  void yyerror(char*);

  tree my_tree;
%}

%union{
  char* name;
  double value;
  tree t;
 }

%token <name> TAG TEXT
%token CLOSE 
%type <t> arbre chaine texte balise 

%%
 //////////////////////////////basic_trees///////////////////////////////////
 /*
end: arbre EOL{
  $$ = $1;
  return 0;
 }
 */
chaine: chaine arbre{
  $$ = join_to_siblings($2, $1);
  my_tree = $$;
 }
|chaine texte{
  $$ = join_to_siblings($2, $1);
  my_tree = $$;
 }
|texte{
  $$ = $1;
  my_tree = $$;
 }
|arbre{
  $$ = $1;
  my_tree = $$;
 }
;

arbre: balise chaine CLOSE{
  $$ = join_to_parent($2, $1);
  my_tree = $$;
 };

texte: TEXT{
  $$ = create_txt_tree($1);
  my_tree = $$;
 }

balise: TAG{
  $$ = create_tree($1);
  my_tree = $$;
 }

 //////////////////////arithmetic_expressions///////////////////////////////////
 ////////////////////////////mySyntax_grammar///////////////////////////////////
 //////////////////////functions///////////////////////////////////
%%

int main(){
  int ret;
  ret = yyparse();
  printf("\n\n");
  display_tree(my_tree);
  return 0;
 }
