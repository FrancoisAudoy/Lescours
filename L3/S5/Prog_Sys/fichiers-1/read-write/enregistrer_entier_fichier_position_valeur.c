#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>


int main(int argc, char **argv){

  if(argc !=4){
    fprintf(stderr,"Argument1: nomfichier | Argument2: position de l entier a ajouter | Argument3: entier a ajouter");
    exit(1);
  }
  
  int fd= open(argv[1],O_WRONLY);
  if(fd==-1){
    perror("open");
    exit(1);
  }

  int position= atoi(argv[2]);
  int entier= atoi(argv[3]);
		     
  lseek(fd ,position*sizeof(int) , SEEK_SET);

  write(fd, &entier, sizeof(int));

  return EXIT_SUCCESS;
}
