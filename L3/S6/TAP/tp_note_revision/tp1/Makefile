CC = gcc
CFLAGS = -Wall -g -Wno-unused-function
LDLIBS = -lm

cor: tp1.cor.c tp1-tools.c
	$(CC) $(CFLAGS) $^ $(LDLIBS) -o $@

tp1: tp1.c tp1-tools.c
	$(CC) $(CFLAGS) $^ $(LDLIBS) -o $@

clean:
	rm cor
	rm tp1
