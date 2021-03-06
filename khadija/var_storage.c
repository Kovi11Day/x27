#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "var_storage.h"

variable create_variable (char* name, struct ast* value);
void destroy_variable (variable v);
int storage_full (storage s);
void extend_storage (storage s);
void add_variable (storage s, variable v);
void* find_variable (storage s, char* name);


storage create_storage(){
  //printf("in create_storage\n");
  storage s = malloc (sizeof (struct storage_t));
  s->num_elements = 0;
  s->tab = malloc (init_size * sizeof(variable));
  s->size = init_size;
  return s;
}

void destroy_variable (variable v){
  //printf("in destroy_variable\n");
  free(v);
}

void destroy_storage(storage s){
  //printf("in destroy_storage\n");
    free (s->tab);
    free (s);
}

variable create_variable (char* name, struct ast* value){
  //printf("in create_variable\n");
  variable v = malloc (sizeof (struct variable_t));
  v->var_name = name;
  v->var_value = value;
  return v;
}

void extend_storage (storage s){
  variable* new_tab = malloc (2 * s->size * sizeof(variable));
  for (int i = 0; i < s->size; ++i)
    new_tab[i] = s->tab[i];
  free (s->tab);
  s->tab = new_tab;
}

int storage_full (storage s){
  return s->size == s->num_elements;
}

void add_variable (storage s, variable v){
  //printf("in add variable\n");
  if (storage_full(s))
    extend_storage(s);
  s->tab[s->num_elements] = v;
  ++s->num_elements;
}

void* find_variable (storage s, char* name){
  //printf("in find_variable\n");
    for (int i = 0; i < s->num_elements; ++i){
      if (strcmp(name, s->tab[i]->var_name) == 0)
	return (variable)s->tab[i];
    }
    return NULL;
}

void update_storage(storage s, char* name, struct ast* value){
  //printf("in update_storage with %s\n", name);
  variable found = find_variable(s, name);
  if (found == NULL){
    //not found
    variable v = create_variable (name, value);
    add_variable (s, v);
  }else{
    found->var_value = value;
  }
}

struct ast* get_value (storage s, char* name){
  //printf("in get_value\n");
  variable found = find_variable(s, name);
  if (found == NULL){
    printf("variable not initialized\n");
    return (struct ast*)NULL;
  }
  else
    return found->var_value;
}


/*
int main (){
  storage s = create_storage();
  //variable v = create_variable("var1", 2);
  //add_variable(s, v);
  update_storage (s, "var1", 0);
  variable found = find_variable(s, "var1");
  printf("%s: %d\n", found->var_name, found->var_value);
  update_storage (s, "var1", 1);
  found = find_variable(s, "var1");
  printf("%s: %d\n", found->var_name, found->var_value);
  update_storage (s, "var2", 2);
  found = find_variable(s, "var2");
  printf("%s: %d\n", found->var_name, found->var_value);
  printf("*******************************\n");
  printf ("val var1: %d\n", get_value(s, "var1"));
  destroy_storage(s);
  return 0;
}
*/
