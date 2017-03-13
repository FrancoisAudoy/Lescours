BISON = ex3.y
PROG = $(BISON:.y=.c)
EXE = $(PROG:.c=.exe) 
CFLAG = -g -Wall -std=c99
CC = gcc

all : $(EXE) exo5.exe

$(PROG):$(BISON)
	bison -o$@ $<

$(EXE) :$(PROG)
	$(CC) $(CFLAG) -o $@ $<

exo5.exe : exo5.y exo4.l
	bison -oexo5.c -d --report=all exo5.y
	flex -o exo4.c exo4.l
	$(CC) $(CFLAG) -o $@ exo4.c exo5.c -lfl

.PHONY: clean

clean :
	rm  *.c

mrpropre : clean
	rm *.exe
