#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>

/*
 *permer de communiquer les processus entre deux processus
 *separer les deux fork permet de ne pas executer deux fois la meme chose
 */

int main(int argc, char **argv){

  if(argc < 3){
    perror("probleme d arguments");
    exit(EXIT_FAILURE);
  }

  char *cmd1 = argv[1];
  char *cmd2=argv[2];
  int status;
  
  int pipefd[2];

  if(pipe(pipefd) == -1){
    perror("pipe");
    exit(EXIT_FAILURE);
  }

  int pid =fork(); //creation du premier fils 

  if(!pid){
        
    close(pipefd[0]);
    dup2(pipefd[1],1);
    close(pipefd[1]);
    execlp(cmd1, cmd1,NULL);
  }
  
  int pid2 =fork();//creation du deuxieme 
   
   if(!pid2){    
      close(pipefd[1]);
      dup2(pipefd[0],0);
      close(pipefd[0]);
      execvp(cmd2, argv+2);
    }

   close(pipefd[0]);
   close(pipefd[1]);
 

  
  waitpid(pid, &status, 0);
  waitpid(pid2,&status,0);

  return EXIT_SUCCESS;
}
