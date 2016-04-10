#include <stdlib.h>
#include "additional_ast.h"

struct attributes* create_attribute(char* key, char* value){
	
	struct attributes* att = malloc(sizeof(struct attributes));
	att->key = mk_word(key);
	att->value = mk_word(value);
	att->next = NULL;
	
	return att;
}

struct attributes* add_attribute(struct attributes* att, char* key, char* val ){
  
	att->next = create_attribute(key, val);
	return att;
}

struct ast* join_to_parent (struct ast* daughter, struct ast* parent){
  parent->node->tree->daughters = daughter;
  return parent;
}

struct ast* join_to_siblings(struct ast* new, struct ast* siblings){
  struct ast* last_sibling = siblings->node->tree->last; 
  last_sibling->node->tree->right = new;
  siblings->node->tree->last = new;
  return siblings;
}

struct ast* add_tree_to_forest(struct ast* new, struct ast* jungle){
  jungle->node->forest->tail = new;
  return jungle;
}
