#define _GNU_SOURCE

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

jmp_buf buf;


int main(){
  int i=0 ;
  i= setjmp(buf);
  printf("%d\n",i);
  longjmp(buf,i+1);
    
  return 0;
 
}
