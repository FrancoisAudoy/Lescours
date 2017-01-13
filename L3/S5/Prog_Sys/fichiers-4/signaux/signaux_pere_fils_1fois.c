#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <unistd.h>
#include <sys/wait.h>

void handler_pere(int sig){
  printf(" pere ! recu : %s\n", strsignal(sig));
}

void handler_fils(int sig){
  printf(" fils ! recu : %s\n", strsignal(sig));
}

int main(int argc, char ** argv){

  int pid_fils=fork();
  if(pid_fils == 0){

    int ppid = getppid();

    struct sigaction act;
    act.sa_handler= handler_fils;
    sigemptyset(&act.sa_mask);
    act.sa_flags=0;
    sigaction(SIGUSR1, &act, NULL);
    kill(ppid, 1);
    pause();
  }
  else{
    int status;
    struct sigaction act_pere;
    act_pere.sa_handler = handler_pere;
    sigemptyset(&act_pere.sa_mask);
    act_pere.sa_flags=0;
    sigaction(1,&act_pere,NULL);

    pause();
    kill(pid_fils,SIGUSR1);

    waitpid(pid_fils,&status,0);
  }

  return EXIT_SUCCESS;
}
