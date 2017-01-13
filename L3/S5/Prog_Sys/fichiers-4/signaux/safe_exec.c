#define _GNU_SOURCE
#include <signal.h>
#include <stdio.h>
#include <setjmp.h>
#include "safe_exec.h"

sigjmp_buf buf;

void handler(int sig){
  siglongjmp(buf,1);
}

int essayer( void (*function)(void), int sig){
  
  struct sigaction act;
  act.sa_handler=handler;
  sigemptyset(&act.sa_mask);
  act.sa_flags=0;

  sigaction(sig,&act, NULL);

  if(sigsetjmp(buf,1)){
    act.sa_handler=SIG_DFL;
    return -1;
  }
  function();
  return 0;
}


