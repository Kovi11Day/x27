
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

add_var_tree_to_storage
add_var_val_to_storage
get_var_content

////////////////////////////////////