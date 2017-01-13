#include <math.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

#define MAX  10000000
double resultat[MAX];
int nb_threads;

void *parallelisation(void *p){
  int k = ((int*)p);
  while(k % nb_threads != 0){
    resultat[k] = acos((double)k);
    k++;
  }
}

int main(int argc, char *argv[])
{
  nb_threads = atoi(argv[1]);
  pthread_t pid[nb_threads];
  int thread=0;
  void* val;

  for(int k=0; k < MAX; k++)
    if( k%nb_threads == 0){
      pthread_create(&pid[thread],NULL,parallelisation,(void *)k);
      thread ++;
      if(thread >= nb_threads)	
	thread = 0;
    }
  for(int i=0; i<nb_threads; ++i){
    pthread_join(pid[i],&val);
  }

  return EXIT_SUCCESS;
}
