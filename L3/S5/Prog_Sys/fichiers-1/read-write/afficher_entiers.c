#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>


int main(int argc, char **argv){

  int fd, ret_read=1;
  int s;
  
  fd=open("entiers-generer.txt",O_RDONLY);
  if(fd==-1){
    perror("open");
    exit(1);
  }

  while(ret_read !=0){
   ret_read=read(fd,&s,sizeof(int));
   if(ret_read== -1){
     perror("read");
     exit(1);
   }
 
   write(1,&s,ret_read);
   }

  return EXIT_SUCCESS;
}
