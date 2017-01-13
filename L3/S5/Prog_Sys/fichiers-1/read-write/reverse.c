#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>


int main(int argc, char **argv){
  if(argc !=3){
    fprintf(stderr, "Arg1: Fichier d entrer| Arg2: fichier de sortie\n");
    exit(1);
  }

  char rev_in;
  int size_file;

  int fd_in= open(argv[1],O_RDONLY);
  if(fd_in == 0){
    perror("open");
    exit(1);
  }
  int fd_out= open(argv[2],O_WRONLY|O_CREAT,0666);
  if(fd_out == 0){
    perror("open");
    exit(1);
  }

  size_file=lseek(fd_in,0,SEEK_END);
  
  for(int i= size_file; i>=0 ; --i){
    lseek(fd_in,i*sizeof(char), SEEK_SET);
    read(fd_in, &rev_in, sizeof(char));
    write(fd_out, &rev_in, sizeof(char));
  }

  close(fd_in);
  close(fd_out);

  return EXIT_SUCCESS;
}
