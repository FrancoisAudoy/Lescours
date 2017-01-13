#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>


/*
 *"Simule" un pipe dans un fichier tmp
 *entre deux commande 
 */

int main(int argc, char **argv){

  if(argc < 3){
    perror("error with args\n");
    exit(0);
  }

  char *cmd1=argv[1];
  char *cmd2=argv[2];

  int status;

  int fd;

  pid_t pid =fork();

  if(!pid){
    fd=open("tmp.txt", O_CREAT|O_WRONLY|O_TRUNC, 0666);
    dup2(fd,1);
    close(fd);
    execlp(cmd1,cmd1, NULL);
			      
  }
  else
    waitpid(pid,&status,0);

  pid=fork();
  if(!pid){
    fd=open("tmp.txt", O_RDONLY);
    dup2(fd,0);
    close(fd);
    execvp(cmd2, argv+2);
  }

  else
    waitpid(pid,&status,0);

  
  return EXIT_SUCCESS;
}
