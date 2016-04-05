#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include "tree.h"




tree create_tree (char* label){
	
  tree t =  malloc (sizeof (struct tree));
  t->label = strdup(label);
  t->nullary = 0;
  t->space = 0;  
  t->tp=tr; 
  t->attr = NULL;
  t->daughters = NULL;
  t->right = NULL;
  t->last=t;
  return t;
}

tree create_tree_text(char* label){
	tree p = create_tree("texte");
	tree c = create_tree(label);
	p->tp=tr;
	c->tp=word;
	p->daughters = c;
	return p;
}

attributes create_attributes(char* key , char* value){
	
	attributes att =  malloc(sizeof(struct attributes));
	att->key=key;
	att->value=value;
	att->next=NULL;
	
	printf("%s%",att->value);
	return att;
}

void add_attributes(attributes att , char* keys , char* val ){
	
	att->next = create_attributes(keys , val);
	printf("%s%",att->next->value);

}

tree create_tree_with_attributes (char* label, attributes att){
	tree t = create_tree (label);
	t->attr = att;
	  return t;
}	

void tree_to_html(tree t){
	
	switch (t->tp){
		case tr:
			printf("%s",t->label);
			break;
		case word:
			printf("%s",t->daughters->label);
			break;
		default: 
		break;
	}
}

void print_open_tag(tree tr){
	
	printf("<%s>",tr->label);
}

void print_close_tag(tree t){
	
	printf("</%s>",t->label);
		
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


int main (){
attributes attt=NULL;
//~ tree t = create_tree("arbre");	
//~ tree a = create_tree("a");	
//~ tree b = create_tree("e");	
//~ tree c = create_tree_text("text");
//~ join_to_siblings(a ,b);
//~ join_to_siblings(b,c);
//~ join_to_parent(a,t);
//~ tree_to_html(t);
attt= create_attributes("PRO" , "tree");

add_attributes(attt ,"Number","One" );
return 0;	
}

