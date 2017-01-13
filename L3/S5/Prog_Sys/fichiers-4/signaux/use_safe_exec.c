#include "safe_exec.h"
#include <stdlib.h>
#include <stdio.h>

void g(){
  char *a= NULL;
  char b;
  b=*a;
  printf("%c\n",b);
}

void f (){
  int *a=NULL;
  int b;
  essayer(g,11);
  b=*a;
  printf("%d\n", b);
}

int main( int argc, char **argv){
  if(argc < 2){
    perror("Il manque un argument");
    exit(EXIT_FAILURE);
  }

  int r;
  r=essayer(f, atoi(argv[1]));

  if(r==0)
    printf("La fonction s'est bien derouler \n");
  else
    printf("la fonction a echoueé\n");

  return EXIT_SUCCESS;
}
