
/////////////////////////////////////gestion de variables
variable_storage.h
enum var_type {tree, arith_tree, forest};

struct variable{
var_type type;
char* iden;
Expression e;
forest* forest; //eventuellement (ignore for now)
};

create_var(iden, Expression);
destroy
//modify_var(variable, Expression nw_val)
getval(iden)

struct storage_var{
	liste de variables
}

create
destroy

//essayer d'avoir deux fonctions meme nom mais differents parametress
struct storage{
	}
add_var_to_storage(storage, iden, Expression expr){
	if (expr->type == tree)
		add_var_tree_to_storage (storage, iden, expr->tree);
	else ...
}
Expression/NULL find_var_in_storage(char* iden)
//////////////////////////Stack_storage

struct stack_var_storage

create_local_storage() == push == push_new_str_context
disguard_local_storage() == pop == pop_cur_str_context

get_var(iden) // cherche la iden en commencant du niveau le plus haut
//si iden d'existe pas dans le plus haut niveau, il cherche dans le niveau en dessous etc...

add_var(iden, exp)
///////////////////////////Expression
struct Expression{
	enum type {tree, arith}
	tree arbre_html
	tree expr_arith
}	
////////////////////////////////////gestion stockage de fonctions
 
gestion de stockage de fonctions

struct fonctions{
	char* fname;
	pointeur vers une fonction definie;
}

////////////////////////////g-trees//////////////////////////

struct gtree{
	Expression expr
	char* name
	enum gtree_type = {var_local let  fun expr rec ... (les mot clefs du prog)
}

create
destroy
add //voir quel shema utiliser

////////////////////evaluer g-trees////////////

case gtree_type == var_local{
//notez: fonction recursif
evaluer(fd)
replace_var_in_tree (cur_node->fg->arbre_html, get_)

create_gnode_loc_var(gtree affec, gtree exp)
	
/////////////NOUVELLE DECOUVERTE//////////////////
tout les arbres utilisent la meme structure: daughters, right ...

donc

struct storage{
	tree exp
	type var_type
	next*
	}			
struct exp
	enum type = {expr_arith, tree, gtree_exp(vraiment necessaire??)}
	tree data