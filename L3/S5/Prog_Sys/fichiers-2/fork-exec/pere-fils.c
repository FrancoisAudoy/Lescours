#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>

int main(void){

  pid_t Pid;

  Pid= fork();

  if(Pid){
    exit(1); //transforme le fils en orphelin
    // sleep(30); //transforme le fils en zombie
    // printf("Je m'appelle %d et je suis le pere de %d\n", getpid(), Pid);
  }
  else{
      printf("Je m'appelle %d et je suis le fils de %d\n", getpid(), getppid());
  }

  return 1;
}

