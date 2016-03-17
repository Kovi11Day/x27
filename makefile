CC=gcc
LEX=flex
YACC=bison -d -v
LDLIBS=-ll -ly -lm
CFLAGS=-std=c99 -g -pedantic -Wall -Wextra -Wshadow -Wpointer-arith -Wcast-qual -Wstrict-prototypes -Wmissing-prototypes

ytab=web_compiler.tab.c web_compiler.tab.h

web_compiler: lex.yy.o web_compiler.tab.o struct_forest.o
	$(CC) -o $@ $(CFLGS) $^ $(LDLIBS)

lex.yy.c: web_compiler.l web_compiler.tab.h
	$(LEX) web_compiler.l

$(ytab): web_compiler.y
	$(YACC) $^

.PHONY: clean

clean:
	rm web_compiler
	rm -f *.o *~ core
	rm *.tab.* lex.yy.c *.output
	rm struct_forest
