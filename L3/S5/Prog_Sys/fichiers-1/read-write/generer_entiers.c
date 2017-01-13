#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>


int main(int argc, char **argv){

  if(argc!=2){
    fprintf(stderr,"Probleme argument\n");
    exit(0);
  }

  int arg=atoi(argv[1]);
  int fd;

  fd=open("entiers-generer.txt",O_WRONLY| O_CREAT,0666);
  if(fd==-1){
    perror("open");
    exit(1);
  }

  for(int i=0; i<arg; ++i){
    write(fd,&i,sizeof(int));
  }

  close(fd);

  return EXIT_SUCCESS;
}
