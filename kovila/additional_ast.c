#include <stdlib.h>
#include <stdio.h>
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

/////////////////////////////////display_tree/////////////////////////////////////////////////
void pre_display_tree(){
  printf("graph{\n");
}

void post_display_tree(){
  printf("}\n");
}

void parcours_ast(struct ast* gtree, int i){
  switch (gtree->type){
  case FOREST:
    printf("forest\n");
    return;
    
 case APP:
    printf("app_%d -- fun_%d\n", i, i+1);
    printf("app_%d -- arg_%d\n", i, i+2);
    parcours_ast (gtree->node->app->fun, i+1);
    parcours_ast (gtree->node->app->arg, i+2);
    return;
    
  case FUN:
printf("fun_%d -- %s_%d\n", i, gtree->node->fun->id, i); 
    printf("fun_%d -- ", i); //body
    parcours_ast (gtree->node->fun->body, i+1);
    return;
  }
}

void display_ast (struct ast* root){
  pre_display_tree();
  parcours_ast(root, 0);
  post_display_tree ();
  return;
}


/* int parcours_display(tree t, int p, int c, char* parent){ */
/*   int ttl = c; */
  
/*   if (t->daughters != NULL) */
/*     ttl = parcours_display(t->daughters, c, c+1, t->label); */

/*   if (t->right != NULL){ */
/*     if (p != -1) */
/*       printf("%s_%d -- %s_%d\n", parent, p, t->label, c); */
/*     ttl = parcours_display(t->right, p, ttl + 1, parent); */
/*   } */

/*   if (t->right == NULL){ */
/*     if (p != -1) */
/*       printf("%s_%d -- %s_%d\n", parent, p, t->label, c); */
/*     return c; */
/*   } */

/*   return ttl; */
  
/* } */

/* void display_tree(tree t){ */
/*   pre_display_tree(); */
/*   parcours_display(t, -1, 0, t->label); */
/*   post_display_tree(); */
/* } */
