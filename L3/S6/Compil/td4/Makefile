BISON = iplp.y
FLEX = iplp.l
SRCUTILS = environ.c node.c
OBJUTILS = $(SRCUTILS:.c=.o)
PROGBISON = $(BISON:.y=bison.c)
PROGFLEX = $(FLEX:.l=flex.c)
EXE = iplp
CFLAG = -g -Wall -std=c99
CC = gcc

all : $(EXE) 

$(PROGBISON):$(BISON)
	bison -d -o$@ $<

$(PROGFLEX) : $(FLEX)
	flex -o $@ $<

iplp: $(PROGBISON) $(PROGFLEX) $(SRCUTILS)
	$(CC) $(CFLAG) -o $@ -I include/ $^ -lfl

$(OBJUTILS) : $(SRCUTILS)
	$(CC) -c $(CFLAG) -o $@ -I include/ $<

.PHONY: clean

clean :
	rm $(EXE) $(OBJUTILS) $(PROGFLEX) $(PROGBISON)
