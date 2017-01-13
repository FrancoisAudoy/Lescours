#define _GNU_SOURCE
#define _POSIX_C_SOURCE >= 1 || _XOPEN_SOURCE || _POSIX_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <unistd.h>
#include <sys/wait.h>

void handler_pere(int sig){
  printf("pere ! recu : %s\n", strsignal(sig));
}

void handler_fils(int sig){
  printf("fils ! ====> reponse recu\n");
}

int main(int argc, char **argv){

  if(argc < 2){
    printf("./signaux_pere_fils signal1 signal2 signal3 ...");
    exit(EXIT_FAILURE);
  }

  printf("pid : %d\n", getpid());
  
  int pid=fork();
  if(!pid){
    
    pid_t ppid= getppid();
    int nb_envoie = atoi(argv[1]);
    int nb_signaux= argc-2;
    int sig[nb_signaux];

    //changement de handler pour sigusr1
    struct sigaction act_fils;
    act_fils.sa_handler = handler_fils;
    sigemptyset(&act_fils.sa_mask);
    act_fils.sa_flags=0;
    sigaction(SIGUSR1,&act_fils, NULL);

    //recuperation de tout les signaux a envoyer
    for(int i=0; i< nb_signaux; ++i){
      sig[i]= atoi(argv[i+2]);
    }

    sigset_t sigmask;
    sigfillset(&sigmask);
    sigdelset(&sigmask, SIGUSR1);
    
    //envoie les signaux et attent l'acquitement
    for(int k=0; k< nb_envoie; k++){
      for(int i=0; i < nb_signaux; i++){
	kill(ppid,sig[i]);
	//pause();
	sigsuspend(&sigmask);
      }
    }
  }
    else{
      
      //int status;
      struct sigaction act;
      act.sa_handler= handler_pere;
      sigemptyset(&act.sa_mask);
      act.sa_flags=0;
      for(int i=0; i<=NSIG; ++i){
	if(i!=SIGKILL && i!=SIGSTOP)
	  sigaction(i, &act, NULL);
      }

      for(int i=0; i<argc-2; ++i){
	pause();
	kill(pid, SIGUSR1);
      }
    }
  return EXIT_SUCCESS;
}

