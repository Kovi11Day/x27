
struct forest
struct tree;
struct attributes;

typedef struct forest* forest;
typedef struct tree* tree;
typedef struct attributes* attributes;

enum tree_type {tree, word}; //typage de noeuds: noeud construit d'un arbre ou texte
enum forest_type {forest, tree};

struct attributes{
  char* key; //nom de l'attribut
  char* value; //valeur de l'attribut
  struct attributes *next; //attribut suivant
};

struct tree{
  char* label; //ettiquette du noeud
  bool nullary; //noeud vide, par exemple <br/> 
  bool space; //noeud suivi d'un espace
  enum tree_type type; //type du noeud. nullary doit etre true si tp vaut word
  ////tp: feuille: daughter of text node word=feuille empty=feuille
  attributes attr; //arributes du noeud ...list
  tree daughters; //fils gauche, qui doit etre NULL si nullary est true
  tree right; //frere droit
};

struct forest{
  enum forest_type type;
  forest daughters;
  forest right;
  bool nullary;
};

//ajouter struct forest pour pouvoir representer un ficher en entier//

forest create_forest ();
void destroy_forest ();
void forest_to_xml (forest f);

