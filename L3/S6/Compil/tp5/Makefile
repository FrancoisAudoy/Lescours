SRCBISON = $(wildcard *.y)
SRCFLEX = $(SRCBISON:.y=.l)
CBISON = $(SRCBISON:.y=bison.c)
HBISON = $(CBISON:.c=.h)
CFLEX = $(SRCFLEX:.l=flex.c)
EXE = td5

all : $(EXE)

td5 : $(CBISON) $(CFLEX) environ.o
	gcc -g -o $@ $^ -lfl

$(CBISON): $(SRCBISON)
	bison -d -o$@ $<

$(CFLEX): $(SRCFLEX)
	flex -o $@ $<

environ.o : environ.c environ.h
	gcc -c -std=c99 -g -o $@ $< 

clean:
	rm -f $(CBISON) $(CFLEX) $(EXE) $(HBISON) environ.o
