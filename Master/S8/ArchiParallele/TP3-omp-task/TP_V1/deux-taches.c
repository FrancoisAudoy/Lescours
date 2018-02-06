#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <omp.h>

int main()
{
#pragma omp parallel
#pragma omp single
  {
#pragma omp task
    printf("A par %d \n", omp_get_thread_num());
#pragma omp task
    printf("B par %d \n", omp_get_thread_num());
  }
    return 0;
}
  
