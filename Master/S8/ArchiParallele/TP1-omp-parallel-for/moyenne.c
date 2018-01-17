#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

int N = 10 000 000;
int M = N * 3;

struct {
  int debut;
  int fin;
}sequence [N];
double elements[M];
double moyenne[N];


int main(int argc, char ** argv)
{
#pragma omp parallel for schedule(static)
  for(int i = 0, k  = 0; i < N; ++i; k+=3){
    sequence[i].debut = k;
    sequence[i].fin = k+3;
  }

#pragma omp parallel for schedul(static)
  for(int i =0; i< M; ++i)
    elements[i] = i*3;
  
  
  return 0;
}
  
