#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include "struct_forest.h"

tree create_tree (char* label){
  //init
  //label =label
  //nullary = 0 //par defaut pas feuille
  //space = 0
  //type = tree //par defaut pas feuille
  //attr = NULL
  //daughters = NULL
  //right = NULL
}
void destroy_tree (tree t){//recursif}

forest create_forest (void){
  return NULL;
}

//Pas encore bien testé :Ibrahim
void destroy_tree (tree root){

while(root!=NULL){
if((root->daughter && root->right)==NULL)
	free(root);
else {
	if(root->right==NULL) 
	destroy_tree(root->daughters);
else
	destroy_tree(root->right);
	}	
}
//to go faster
tree create_text_tree (char* word){}

void forest_to_xml (forest f){
  //parcours profondeur + largeur
  //racine -> premier fils jusqu'au feuille ->
  //chaque fois qu'on remonte on passe au frere
}
  
 
  

int main (void){

  tree second_word = create_tree("est");
  first_word->nullary = 1;
  first_word->type = word;
  
  tree first_word = create_tree("ceci");
  first_word->nullary = 1;
  first_word->type = word;

  tree second_text = create_tree("text");
  first_text->daughters = second_word;
  
  tree first_text = create_tree("text");
  first_text->daughters = first_word;
  first_text->right = second_text;
  
  tree root_tree = create_tree("div");
  root_tree->daughters = first_text;


  
  return 0;
}

