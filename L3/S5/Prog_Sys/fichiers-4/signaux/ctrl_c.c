#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>

void  handler(int sig){
  printf("No! You don't stop !\n");
}

int main( int argc, char ** argv){

  struct sigaction act;
  act.sa_handler = handler;
  sigemptyset(&act.sa_mask);
  act.sa_flags=SA_RESETHAND;
  
  sigaction(SIGINT, &act,NULL );
  while(1);

  return EXIT_SUCCESS;
}
  
