CC=gcc
LEX=flex
LDLIBS= -lfl -ly -lm
CFLAGS= -Wall
YACC=bison
YFLAGS= -v -d -g --report=all

%.tab.c: %.y
	$(YACC) $(YFLAGS) -o $@ $<

%.yy.c: %.l
	$(LEX) $(LFLAGS) -o $@ $<

main.out: main.o calc.tab.o calc.yy.o
	$(CC) -o main.out calc.yy.o calc.tab.o main.o $(LDLIBS)

%_main.out: %_main.c %.tab.o %.yy.o
	$(CC) $(CFLAGS) -o $@ $(word 3,$^) $(word 2,$^) $< $(LDLIBS)

%.output: %_main.out %.input
	./$< < $(word 2, $^) > $@ && cat $@

.PHONY: clean

clean:
	rm -f *.o *.tab.c *.tab.h *.yy.c *.out core *output
