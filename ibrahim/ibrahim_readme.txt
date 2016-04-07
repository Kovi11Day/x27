////structure attributes////
create_attribute(char* key, char* value);

add_attributes (attribute attr, char* key, char* value);

////structure tree/////

create_empty_tree(char* label); //nullary = 1

create_tree_with_attributes (char* label, attribute att);

///////////////fonction manip tree/////////////////////

void replace_var_in_tree(tree main_tree, char* iden, tree replacement_tree);

evaluer_noeud_var_loc; //create_local_storage


