#include "safe_exec.h"

#include <stdio.h>
#include <stdlib.h>

  int * a = NULL;
  int b=3;

void fonction(){
  int d =*a;
  printf("%d\n",d);
}

int main (int argc,char ** argv){

  if(essayer(fonction,11) == 0)
    printf("ca a marche\n");
  else
    printf("ca n a pas marche\n");
}
