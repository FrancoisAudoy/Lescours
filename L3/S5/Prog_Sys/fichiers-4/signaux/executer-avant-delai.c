#define _GNU_SOURCE

#include "executer-avant-delai.h"

#include <sys/wait.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/types.h>
#include <string.h>
#include <signal.h>
#include <sys/time.h>
#include <errno.h>
#include <setjmp.h>

int pid;
jmp_buf buf;

void handler_sigaction(int sig){
  siglongjmp(buf,1);
}

int executer_avant_delai(void (*fun)(void *), void *parametre, int delai){  
  
  struct sigaction act;
  act.sa_handler= handler_sigaction;
  sigemptyset(&act.sa_mask);
  act.sa_flags=0;
  sigaction(SIGALRM,&act, NULL);

  alarm(delai);

  if(sigsetjmp(buf,1)){
    act.sa_handler= SIG_DFL;
    sigaction(SIGALRM,&act, NULL);
    return 0;
  }
  
  fun(parametre);
  act.sa_handler= SIG_DFL;
  sigaction(SIGALRM,&act,NULL);
  return 1;
}
