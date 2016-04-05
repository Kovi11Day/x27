

#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

struct tree;
typedef struct tree* tree;
typedef struct attributes* attributes;
typedef enum {tr, word} type;        //typage des nœuds: permet de savoir si un nœud construit
                          //un arbre ou s'il s'agit simplement de texte

struct attributes{
    char * key;               //nom de l'attribut
    char * value;             //valeur de l'attribut
    struct attributes * next; //attribut suivant
};

struct tree {
    char * label;              //étiquette du nœud
    bool nullary;              //nœud vide, par exemple <br/>
    bool space;                //nœud suivi d'un espace
    type tp;              //type du nœud. nullary doit être true s tp vaut word
    struct attributes * attr;  //attributs du nœud
    tree daughters;   //fils gauche, qui doit être NULL si nullary est true
    tree right;       //frère droit
    tree last;
};
