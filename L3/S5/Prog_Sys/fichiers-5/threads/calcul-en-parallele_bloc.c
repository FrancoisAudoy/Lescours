#include <math.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

#define MAX  10000000
double resultat[MAX];
int nb_threads;
int bloc;

void *parallelisation(void *p){
  int k = (*(int*)p);
  int fin = k+bloc;
  while(k < fin && k<=MAX){
    resultat[k] = acos((double)k);
    k++;
  }
}

int main(int argc, char *argv[]){
  
  nb_threads = atoi(argv[1]);
  pthread_t pid[nb_threads];
  int thread=0;
  void* val;
  bloc = MAX/nb_threads + MAX%nb_threads;

  for(int k=0*bloc; k < nb_threads; k++){
    pthread_create(&(pid[thread]),NULL,parallelisation,(void *)&k);
      thread ++;
    }
  
  for(int i=0; i<nb_threads; ++i){
    pthread_join(pid[i],&val);
  }

  return EXIT_SUCCESS;
}
