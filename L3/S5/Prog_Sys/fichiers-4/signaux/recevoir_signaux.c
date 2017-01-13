#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <unistd.h>


void handler(int sig){
  printf(" %s\n", strsignal(sig));
}

int main(int argc, char **argv){

  printf("%d \n", getpid());

  struct sigaction act;
  act.sa_handler= handler;
  sigemptyset(&act.sa_mask);
  act.sa_flags=0;

  for(int i=0; i<=NSIG; ++i){
    sigaction(i, &act, NULL);
  }

  while(1);

  return EXIT_SUCCESS;
}
    
