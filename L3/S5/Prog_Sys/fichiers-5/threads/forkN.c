#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/wait.h>


int main (int argc, char *argv[])
{  
  int pid, n;

  n = atoi(argv[1]);
  
  for(int i = 0 ; i < n ; i++) {
    
    // création d'un nouveau processus fils...
    if( (pid = fork()) == 0) {      
      // le processus fils continue ici
      printf("fork du processus fils %d (pid = %d)\n",i, getpid());
      return EXIT_SUCCESS; // fin du processus fils
    }
    
  }
  
  // le père attend tout ces fils
  for(int i = 0 ; i < n ; i++) {
    wait(NULL); // j'attend la fin de une de mes fils...
  }
  
  printf("fin du processus principal %d\n",getpid());
  
  return EXIT_SUCCESS;
}
