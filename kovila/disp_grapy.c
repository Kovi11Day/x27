void display_graph(char* filename, struct ast* ast){
  FILE* graph = fopen(filename, "w");
  fprintf(graph, "graph{\n");
  fprintf(graph, "ratio = fill;\n");
  fprintf(graph, "node [style=filled];\n");
  dis_gr_rec(graph, ast, 0);
  fprintf(graph, "}\n");
  fclose(graph);
}

void dis_gr_rec (FILE* graph, struct ast* ast, int i){
  enum ast_type tp = get_ast_type(ast);
  
  switch(tp){
    
  case FOREST:
    fprintf(graph, "forest%d\n", i);
    fprintf(graph, "forest%d [color=\"chartreuse1\"]\n", i);
    if(ast->node->forest->head != NULL)
      {fprintf(graph, "forest%d -- ", i); dis_gr_rec(graph, ast->node->forest->head, i+1);}
    if(ast->node->forest->tail != NULL)
      {fprintf(graph, "forest%d -- ", i); dis_gr_rec(graph, ast->node->forest->tail, i+2);}
    break;
    
  case TREE:
    fprintf(graph, "\"tree%d:%s\"\n", i, ast->node->tree->label);
    if(ast->node->tree->daughters){
      fprintf(graph, "\"tree%d:%s\" -- ", i, ast->node->tree->label);
      dis_gr_rec(graph, ast->node->tree->daughters, i+1);
    }
    break;

  case WORD:
    fprintf(graph, "\"txt%d:%s\"\n", i, ast->node->str);
    fprintf(graph, "\"txt%d:%s\" [color=\"blanchedalmond\"]\n", i, ast->node->str);
    break;
    
   case DECLREC:
    fprintf(stderr, "tree should contain only tree, forest, word nodes\n");
    exit(1);
    break;
  case COND:
    fprintf(stderr, "tree should contain only tree, forest, word nodes\n");
    exit(1);
    break;
  case MATCH:
    fprintf(stderr, "tree should contain only tree, forest, word nodes\n");
    exit(1);
    break;
  case FUN:
    fprintf(stderr, "tree should contain only tree, forest, word nodes\n");
    exit(1);
    break;
  case APP:
    fprintf(stderr, "tree should contain only tree, forest, word nodes\n");
    exit(1);
    break;
  case IMPORT:
    fprintf(stderr, "tree should contain only tree, forest, word nodes\n");
    exit(1);
    break;
  case VAR:
    fprintf(stderr, "tree should contain only tree, forest, word nodes\n");
    exit(1);
    break;
  case UNARYOP:
    fprintf(stderr, "tree should contain only tree, forest, word nodes\n");
    exit(1);
    break;
  case BINOP:
    fprintf(stderr, "tree should contain only tree, forest, word nodes\n");
    exit(1);
    break;
  case INTEGER:
    fprintf(stderr, "tree should contain only tree, forest, word nodes\n");
    exit(1);
    break;
  
  }

  return;
}
