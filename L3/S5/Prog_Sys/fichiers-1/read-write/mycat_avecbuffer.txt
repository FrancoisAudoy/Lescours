#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>


int main(int argc, char **argv){

  char s[10];
  int nb_carac_lu;
  FILE *file_in= fopen("mycat_avecbuffer.c", "r");
  FILE *file_out= fopen("mycat_avecbuffer.txt", "w");

  while(!feof(file_in) ){
    nb_carac_lu=fread(s,sizeof(char),10,file_in);
    if(ferror(file_in)){
      perror("read");
      exit(1);
    }
    fwrite(s,sizeof(char),nb_carac_lu,file_out);
  }

  fclose(file_in);
  fclose(file_out);
  
  return EXIT_SUCCESS;
}
