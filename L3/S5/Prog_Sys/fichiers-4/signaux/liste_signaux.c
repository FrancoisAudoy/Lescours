#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>

int main(int argc, char **argv){

  int num_signale=0;
  char *nom_signale = strsignal(num_signale);

  while(num_signale <= NSIG){
    printf(" signale %d : %s\n", num_signale, nom_signale);

    ++num_signale;
    nom_signale = strsignal(num_signale);
  }

  return EXIT_SUCCESS;
}
