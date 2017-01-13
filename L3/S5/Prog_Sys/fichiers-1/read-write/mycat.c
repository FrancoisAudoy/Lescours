#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>


int main(int argc, char **argv){

  char s[10];
  int nb_carac_lu;

  do{
    nb_carac_lu=read(0,s,10);
    if(nb_carac_lu ==-1){
      perror("read");
      exit(1);
    }
    write(1,s,nb_carac_lu);
  }while(nb_carac_lu !=0);
  
  return EXIT_SUCCESS;
}
