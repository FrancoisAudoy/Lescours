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
  int size=0;

  pipe(pipefd);

  int pid=fork();
  if(!pid){
    while(write(pipefd[1],&size, 1)){
      size++;
      printf("%d \n",size);
    }
  }
 

  return EXIT_SUCCESS;
}
