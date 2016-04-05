
/////////////////////////////////////gestion de variables
variable_storage.h
enum var_type {tree, number, forest};

struct variable{
var_type var_type;
char* iden;
tree* tree;
double value;
forest* forest; //eventuellement (ignore for now)
};

create_tree_var(iden, tree);
create_value_var(iden, value);

destroy


struct storage_var{
	liste de variables
}

create
destroy

//essayer d'avoir deux fonctions meme nom mais differents parametres

add_var_to_storage(storage, iden, Expression expr){
	if (expr->type == tree)
		add_var_tree_to_storage (storage, iden, expr->tree);
	else ...
}
	
add_var_tree_to_storage(storage, iden, tree)
add_var_val_to_storage(storage, iden, val)
get_var_content

struct stack_storage_var

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


	