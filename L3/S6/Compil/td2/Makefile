FLEX = exo1.l exo3.l exo4.l exo5.l
CFLEX = flex
CC = gcc
CFLAGS = -lfl -Wall
PROG = $(FLEX:.l=.c)
EXE = $(PROG:.c=.exe)
SOURCE = environ.c bilquad.c

all: todo 

%.c: %.l
	$(CFLEX) -i --outfile=$@ $<

%.exe: %.c
	$(CC) -g -o $@  $< $(CFLAGS)

exo6.exe: exo6.c $(SOURCE)
	$(CC) -g -o $@ $^ $(CFLAGS)



todo: $(EXE)

.PHONY: mrpropre clean

clean:
	rm -rf $(PROG)

mrpropre: clean
	rm -rf *.exe

