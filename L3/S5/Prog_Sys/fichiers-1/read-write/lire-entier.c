#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>


int main(int argc, char **argv){
  if(argc !=3){
    fprintf(stderr, "Arg1: Fichier| Arg2: position\n");
    exit(1);
  }

  int fd= open(argv[1],O_RDONLY);
  int fd_error= open("ERREURS_LIRE.log", O_WRONLY|O_CREAT, 0666);
  dup2(fd_error, 2);
  close(fd_error);
  if(fd == -1){
    perror("open");
    exit(1);
  }

  int position= atoi(argv[2]);
  int s;

  lseek(fd, position*sizeof(int), SEEK_SET);

  read(fd, &s,sizeof(int));

  printf("%d\n",s);

  close(fd);
  close(2);

  return EXIT_SUCCESS;
}
