#include <stdlib.h>
#include "ast.h"
#include <stdio.h>

struct ast * mk_node(void){
    struct ast *e = malloc(sizeof(struct ast));
    e->node = malloc(sizeof(union node));
    return e;
}

struct ast * mk_integer(int n){
    struct ast * e = mk_node();
    e->type = INTEGER;
    e->node->num = n;
    return e;
}
struct ast * mk_binop(enum binop binop){
    struct ast * e = mk_node();
    e->type = BINOP;
    e->node->binop = binop;
    return e;
}
struct ast * mk_unaryop(enum unaryop unaryop){
    struct ast * e = mk_node();
    e->type = UNARYOP;
    e->node->unaryop = unaryop;
    return e;
}
struct ast * mk_var(char * var){
    struct ast * e = mk_node();
    e->type = VAR;
    e->node->str = var;
    return e;

}
struct ast * mk_import(struct path * chemin){
    struct ast * e = mk_node();
    e->type = IMPORT;
    e->node->chemin = chemin;
    return e;
}
struct ast * mk_app(struct ast * fun, struct ast * arg){
    struct ast * e = mk_node();
    e->type = APP;
    e->node->app = malloc(sizeof(struct app));
    e->node->app->fun = fun;
    e->node->app->arg = arg;
    return e;
}
struct ast * mk_word(char * str){
    struct ast * e = mk_node();
    e->type = WORD;
    e->node->str = str;
    return e;
}
struct ast * mk_tree(char * label, bool is_value, bool nullary, bool space,
                     struct attributes * att, struct ast * daughters){
    struct ast * e = mk_node();
    e->type = TREE;
    e->node->tree = malloc(sizeof(struct tree));
    e->node->tree->label = label;
    e->node->tree->is_value=is_value;
    e->node->tree->nullary=nullary;
    e->node->tree->space=space;
    e->node->tree->attributes=att;
    e->node->tree->daughters=daughters;
    return e;
}
struct ast * mk_forest(bool is_value, struct ast * head, struct ast * tail){
    struct ast * e = mk_node();
    e->type = FOREST;
    e->node->forest = malloc(sizeof(struct forest));
    e->node->forest->is_value = is_value;
    e->node->forest->head=head;
    e->node->forest->tail=tail;
    return e;
}
struct ast * mk_fun(char * id, struct ast * body){
    struct ast * e = mk_node();
    e->type = FUN;
    e->node->fun = malloc(sizeof(struct fun));
    e->node->fun->id = id;
    e->node->fun->body=body;
    return e;
}
struct ast * mk_match(struct ast * ast, struct patterns * patterns){
    struct ast * e = mk_node();
    e->type = MATCH;
    e->node->match = malloc(sizeof(struct match));
    e->node->match->ast = ast;
    e->node->match->patterns=patterns;
    return e;
}
struct ast * mk_cond(struct ast * cond, struct ast * then_br, struct ast * else_br){
    struct ast * e = mk_node();
    e->type = COND;
    e->node->cond = malloc(sizeof(struct cond));
    e->node->cond->cond = cond;
    e->node->cond->then_br=then_br;
    e->node->cond->else_br=else_br;
    return e;
}

struct ast * mk_declrec(char * id, struct ast * body){
    struct ast * e = mk_node();
    e->type = DECLREC;
    e->node->fun=malloc(sizeof(struct fun));
    e->node->fun->id = id;
    e->node->fun->body=body;
    return e;
}


//additional------------------------------------------------------
struct attributes* create_attribute(char* key, char* value){
	struct attributes* att = malloc(sizeof(struct attributes));
	att->key = mk_word(key);
	att->value = mk_word(value);
	att->next = NULL;
	att->is_value=1;
	return att;
}

struct attributes* add_key_to_attr(struct attributes* att, char* key){
  if (att->key == NULL){
    att->key = mk_word(key);
    return att;
  }else{
    att->next = create_attribute(key, NULL);
    return att->next;
  }
}

struct attributes* add_val_to_attr(struct attributes* att, char* value){
  att->value = mk_word(value);
  return att->next;
}

/* struct attributes* add_attribute(struct attributes* att, char* key, char* val ){ */
/* 	att->next = create_attribute(key, val); */
/* 	return att; */
/* } */

struct ast* add_daughters (struct ast* parent, struct ast* daughters){
  parent->node->tree->daughters = daughters;
  return parent;
}


//------------------------------------------------------

