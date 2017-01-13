#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>

int main(int argc, char **argv){

  if(argc < 3 ){
    perror("./multi_pipe <cmd1> <cmd2> ... ");
    exit(EXIT_FAILURE);
  }

  int pid, pid2, pid3;
  int pipefd[2];
  int pipefd2[2];
  int status;
  pipe(pipefd);
  
  
  // for(int i=1; i<argc; ++i){
  int i=1;
    pid=fork();
    if(!pid){
      // dup2(pipefd[0],0);
      close(pipefd[0]);
      dup2(pipefd[1],1);
      close(pipefd[1]);
      execlp(argv[i], argv[i],NULL);
    }

    pipe(pipefd2); 
    ++i;
    pid2=fork();
    if(!pid2){
      close(pipefd[1]);//fermeture de la sortie du premier pipe
      dup2(pipefd[0],0);
      close(pipefd[0]); //entrée standard premier pipe
      dup2(pipefd2[1],1);
      close(pipefd2[1]);// sortie standard second pipe
      execlp(argv[i],argv[i], NULL);
    }
    
    //fermeture de finitive du premier pipe
    close(pipefd[0]);
    close(pipefd[1]);

    
    ++i;
    pid3=fork();
    if(!pid3){
      dup2(pipefd2[0],0);
      close(pipefd2[0]);
      close(pipefd2[1]);
      execlp(argv[i], argv[i], NULL);
    }
    //}
  close(pipefd2[0]);
  close(pipefd2[1]);

  for(int i=0; i< argc-1; ++i)
    waitpid(-1,&status,0);
    
  return EXIT_SUCCESS;
}
