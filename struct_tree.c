#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include "struct_tree.h"

tree create_leaf(char* label);
void pre_display_tree(void);
void post_display_tree(void);
int parcours_display(tree t, int p, int c, char* parent);
  
tree create_tree (char* label){
  tree t = malloc (sizeof (struct tree));
  t->label = strdup(label);
  t->nullary = 0;
  t->space = 0;
  //t.type = mytree;
  t->attr = NULL;
  t->daughters = NULL;
  t->right = NULL;

  t->last = t;
  return t;
}

tree create_leaf (char* label){
  tree t = malloc (sizeof (struct tree));
  
  t->label = strdup(label);
  t->nullary = 1;
  t->space = 0;
  //t.type = mytree;
  t->attr = NULL;
  t->daughters = NULL;
  t->right = NULL;

  t->last = NULL;
  return t;
}

tree join_to_parent (tree daughter, tree parent){
  parent->daughters = daughter;
  return parent;
}

tree join_to_siblings(tree new, tree siblings){
  siblings->last->right = new;
  siblings->last = new;
  return siblings;
}

tree create_txt_tree(char* label){
  tree root = create_tree("text");
  root->daughters = create_leaf(label);
  return root;
}


//////////////////////////////////////////////////////////////////////////////////
void pre_display_tree(){
  printf("graph{\n");
}

void post_display_tree(){
  printf("}\n");
}

int parcours_display(tree t, int p, int c, char* parent){
  int ttl = c;
  
  if (t->daughters != NULL)
    ttl = parcours_display(t->daughters, c, c+1, t->label);

  if (t->right != NULL){
    if (p != -1)
      printf("%s_%d -- %s_%d\n", parent, p, t->label, c);
    ttl = parcours_display(t->right, p, ttl + 1, parent);
  }

  if (t->right == NULL){
    if (p != -1)
      printf("%s_%d -- %s_%d\n", parent, p, t->label, c);
    return c;
  }

  return ttl;
  
}

void display_tree(tree t){
  pre_display_tree();
  parcours_display(t, -1, 0, t->label);
  post_display_tree();
}
  
//////////////////////////////////////////////////////////////////////////////////
