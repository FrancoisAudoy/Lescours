#include<stdio.h>
#include<stdlib.h>
#include <fcntl.h>
#include <stdint.h>
#include <unistd.h> // lseek

int main(){
  //printf("Hello\n ");
  write(2,"Hello World", 11);
  return 1;
}
