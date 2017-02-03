FLEX = $(wildcard *.l)
CFLEX = flex
CC = gcc
CFLAGS = -lfl -Wall
PROG = $(FLEX:.l=.c)
EXE = $(PROG:.c=.exe)


all: todo 

%.c: %.l
	$(CFLEX) -i --outfile=$@ $<

%.exe: %.c
	$(CC) -o $@  $< $(CFLAGS)

todo: $(EXE)

.PHONY: mrpropre

clean:
	rm -rf *.c

mrpropre: clean
	rm -rf *.exe

