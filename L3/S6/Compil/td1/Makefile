FLEX = $(wildcard *.l)
CFLEX = flex
CC = gcc
CFLAGS = -lfl -Wall
PROG = $(FLEX: .l = .c)

%.l : %.c
	$(CFLEX) $@

exe : $(PROG)
	$(CC) -o $< $< 
