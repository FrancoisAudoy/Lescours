#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>
#include <errno.h>
#include <string.h>

int main( int argc, char **argv){

  if(argc < 2){
    fprintf(stderr,"Le nombre d argument est insufisant");
    exit(0);
  }

  int pid= fork();
  int status;
  
  if(!pid){
    execvp(argv[1],argv+1);
   if(errno){
     perror(strerror(errno));
   }
  }
  else
    waitpid(pid,&status,WCONTINUED);

  return EXIT_SUCCESS;
}
