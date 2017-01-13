#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>


void System(char *commande){

  pid_t Pid;
  int status;

  Pid=fork();
  
  if(!Pid)
    execlp("/bin/sh","sh","-c",commande,NULL);// execute la commande > sh -c [commande]
  else
    wait(&status);
  
}

int main(int argc, char **argv){

  if(argc !=2){
    fprintf(stderr, "Manque des arguments\n");
    exit(1);
  }

  System(argv[1]);

  return EXIT_SUCCESS;
  
}
