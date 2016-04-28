#include "additional_ast.h"

static const int init_size = 3;

struct variable_t{
  char* var_name;
  struct ast* var_value;
};

typedef struct variable_t* variable;

struct storage_t{
  variable* tab;
  int num_elements;
  int size;
};

typedef struct storage_t* storage;

variable create_variable (char* name, struct ast* value);
storage create_storage (void);
void destroy_storage (storage s);

void update_storage(storage s, char* name, struct ast* value);
//distinguish between adding new variable: declaration
//and updating an existing variable
struct ast* get_value (storage s, char* name);

void add_variable(storage s, variable v);
