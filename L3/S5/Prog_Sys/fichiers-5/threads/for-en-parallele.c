#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

unsigned long volatile k = 0;
const unsigned long MAX = 100 * 1000;
pthread_mutex_t mutex;

void *for_en_parallele(void *p)
{
  int k_loc=0;
  for(unsigned long i=0; i < MAX; i++){
    k_loc++;
  }
  pthread_mutex_lock(&mutex);
  k=k+k_loc;
  pthread_mutex_unlock(&mutex);
    
  return NULL;
}

int 
main(int argc, char *argv[])
{

  int n = atoi(argv[1]);
  pthread_t tids[n];

  pthread_mutex_init(&mutex,NULL);
  
  for(int i = 0; i <n ; i++)
    pthread_create(tids + i, NULL, for_en_parallele, NULL);

  for(int i = 0; i <n ; i++)
    pthread_join(tids[i],NULL);
  
  pthread_mutex_destroy(&mutex);

  printf("%lu\n",k);

  return EXIT_SUCCESS;
}
