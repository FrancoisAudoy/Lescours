BISON = ex3.y
PROG = $(BISON:.y=.c)
EXE = $(PROG:.c=.exe)
CFLAG = -g -Wall -std=c99
CC = gcc

all : $(EXE)

$(PROG):$(BISON)
	bison -o$@ $<

$(EXE) :$(PROG)
	$(CC) $(CFLAG) -o $@ $<
exo5.exe : exo5.y exo4.l
	bison -oexo5.c -d exo5.y
	gcc $(CFLAG) -c -o exo5.o exo5.c
	flex -o exo4.c exo4.l
	gcc $(CFLAG) -c  -o exo4.o exo4.c 
	gcc $(CFLAG) -o analysecal exo4.o exo5.o -lfl

.PHONY: clean

clean :
	rm  *.c

mrpropre : clean
	rm *.exe
