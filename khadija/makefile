CC=gcc
LEX=flex
YACC=bison -d -v
LDLIBS=-ll -ly -lm
CFLAGS=-std=c99 -g -pedantic -Wall -Wextra -Wshadow -Wpointer-arith -Wcast-qual -Wstrict-prototypes -Wmissing-prototypes

ytab=$(name).tab.c $(name).tab.h

$(name): lex.yy.o $(name).tab.o machine.o pattern_matching.o import.o ast.o
	$(CC) -o $@ $(CFLGS) $^ $(LDLIBS)




import.o: import.c machine.h

machine.o: machine.c ast.h pattern.h

pattern_matching.o: pattern_matching.c machine.h ast.h pattern.h

ast.o: ast.c pattern.h chemin.h 



lex.yy.c: $(name).l $(name).tab.h
	$(LEX) $(name).l

$(ytab): $(name).y
	$(YACC) $^

.PHONY: clean

clean:
	rm -f *.o *~ core
	rm *.tab.* lex.yy.c *.output
	rm $(name)
