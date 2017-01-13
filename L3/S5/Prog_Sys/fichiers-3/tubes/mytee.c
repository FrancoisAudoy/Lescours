#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>

int main(int argc, char ** argv){

  if(argc !=2){
    perror("mytee file");
    exit(EXIT_FAILURE);
  }

  char c[1];
  int fd=open(argv[1], O_TRUNC|O_CREAT|O_WRONLY, 0666);
  if(!fd){
    perror("open");
    exit(EXIT_FAILURE);
  }
  
  while(read(0,c,1)){
    write(1,c,1);
    write(fd,c,1);
  }

  return EXIT_SUCCESS;
}
