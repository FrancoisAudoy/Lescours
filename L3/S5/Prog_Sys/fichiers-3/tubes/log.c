#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>

/*Utilise le programme mytee pour ecrire sur le terminal et sur un fichier */

int main(int argc, char **argv){

  if(argc < 3){
    perror("./log <file> <command> [<args>]\n");
    exit(EXIT_FAILURE);
  }
  
  char *file= argv[1];  
  char *cmd= argv[2];
  int pipefd[2];
  int status;
  pipe(pipefd);

  int pid=fork();
  if(!pid){
    close(pipefd[0]);
    dup2(pipefd[1],1);
    close(pipefd[1]);
    execvp(cmd,argv+2);
  }
  
  int pid2=fork();
  if(!pid2){
    close(pipefd[1]);
    dup2(pipefd[0],0);
    close(pipefd[0]);
    execlp("./mytee","mytee",file,NULL);
  }
  
  else{
    close(pipefd[1]);
    close(pipefd[0]);
  }

  waitpid(pid, &status,0);
  waitpid(pid2,&status,0);
  return EXIT_SUCCESS;
}
      
