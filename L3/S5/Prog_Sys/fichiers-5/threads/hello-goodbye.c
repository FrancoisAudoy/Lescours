#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void *HelloGoodbye(void *p)
{
  printf("%p: bonjour\n",(void*) pthread_self()); 
  sleep(1);
  printf("%p: a bientot\n", (void*)pthread_self()); 

  return NULL;
}

int 
main(int argc, char *argv[])
{
  int n =atoi(argv[1]);
  pthread_t pid[n];
  void *ret_thread;
  
  for(int i=0; i<n; ++i)
    pthread_create(&pid[i],NULL,HelloGoodbye,NULL);
  
  for(int i=0; i<n; ++i)
    pthread_join(pid[i],&ret_thread);
  
  HelloGoodbye(NULL);

  return EXIT_SUCCESS;
}
