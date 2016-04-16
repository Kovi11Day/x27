CC=gcc
LEX=flex
YACC=bison -d -v
LDLIBS=-ll -ly -lm
CFLAGS=-std=c99 -g -pedantic -Wall -Wextra -Wshadow -Wpointer-arith -Wcast-qual -Wstrict-prototypes -Wmissing-prototypes

ytab=$(name).tab.c $(name).tab.h

$(name): lex.yy.o $(name).tab.o ast.o additional_ast.o var_storage.o
	$(CC) -o $@ $(CFLGS) $^ $(LDLIBS)


var_storage.o: var_storage.h additional_ast.h
additional_ast.o: additional_ast.c ast.h	
ast.o: ast.c pattern.h chemin.h



lex.yy.c: $(name).l $(name).tab.h
	$(LEX) $(name).l

$(ytab): $(name).y
	$(YACC) $^

.PHONY: clean

clean:
	rm $(name)
	rm -f *.o *~ core
	rm *.tab.* lex.yy.c *.output
