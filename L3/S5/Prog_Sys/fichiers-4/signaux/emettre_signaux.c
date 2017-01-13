#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <unistd.h>

int main(int argc, char ** argv){

  if(argc < 3){
    printf("./emettre_signaux pid_cible k*envoie signal(aux)");
    exit(0);
  }

  pid_t pid= atoi(argv[1]);
  int nb_envoie= atoi(argv[2]);
  int nb_signaux= argc-3;
  int sig[nb_signaux];

  for(int i=0; i< nb_signaux; ++i){
    sig[i]= atoi(argv[i+3]);
  }

  for(int k=0; k< nb_envoie; k++){
    for(int i=0; i < nb_signaux; i++){
      kill(pid,sig[i]);
      sleep(1);
    }
  }
  return EXIT_SUCCESS;
}
