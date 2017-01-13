#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>

int main(int argc, char **argv){

  int pipefd[2];
  int pid;
  int arg= atoi(argv[1]);
  for(int i=2; i<arg-1; ++i){

    pipe(pipefd);

    pid=fork();
    if(!pid){
      dup2(pipefd[1],1);
      close(pipefd[0]);
      close(pipefd[1]);
      //read(0,&c,1);
      //write(1,&c,1);
      execlp(argv[i],argv[i], NULL);
    }

    close(pipefd[1]);
    dup2(pipefd[0],0);
    close(pipefd[0]);
  }

		//read(0,&c,1);
		//write(1,&c,1);
   execlp(argv[arg],argv[arg], NULL);

  // for(int i=0; i< argc-2; ++i)
  //waitpid(-1, NULL, 0);

  return EXIT_SUCCESS;
}
    
