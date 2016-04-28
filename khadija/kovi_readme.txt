/////////////ACTIONS POUR BALISES AVEC ATTRIBUTS///////////

balise: TAG
|TAG suite_cle_valeur{
     $$ = create_tree_with_attributes($1, $2);
;


<attributes>suite_cle_valeur: suite_cle_valeur KEY VALUE{
			      add_attributes($$, $1, $2);
			      }
|KEY VALUE{
$$ = create_attribute($1, $2);
}
;

////////////GRAMMAR EXPRESSION///////


////////////////////GTREE////////////////////

enum type {where, let, in..}
struct gtree{
       Expression* expr;
       char* iden;
       enum type type
       right, left daughters??
       }
