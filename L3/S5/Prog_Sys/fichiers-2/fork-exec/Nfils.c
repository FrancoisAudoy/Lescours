#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>

int main(int argc, char **argv){

  if(argc !=2){
    fprintf(stderr, "il n'y a pas assez darguments\n");
    exit(0);
  }

  int nbFils= atoi(argv[1]);
  pid_t Pid;
  int status;
  
  for(int i=0; i<nbFils; ++i){
    Pid=fork();
      if(Pid== 0){
	printf("%d\n", i);
	exit(1);
      }
  }

  if(Pid){
  for(int i=0; i<nbFils; ++i)
    wait(&status);
  }
  return 1;
  
}
