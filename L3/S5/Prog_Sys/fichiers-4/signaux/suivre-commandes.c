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

#define NCOMMANDES 4

struct etat
{
  pid_t pid;
  char commande[10];
  char arg[10];
  int etat;
};

typedef struct etat* etat;


etat etat_tableau[NCOMMANDES];


char *commandes[NCOMMANDES][10]={
  {"sleep","0",NULL}, 
  {"sleep","3",NULL}, 
  {"sleep","4",NULL}, 
  {"sleep","5", NULL} 
};

void afficher_etat()
{
  int i;
  
  for ( i=0;i<NCOMMANDES;i++)
    {
      switch(etat_tableau[i]->etat)
	{
	case 3:
	  printf("%d : StoppÈ %s(%s)\n",etat_tableau[i]->pid,etat_tableau[i]->commande,etat_tableau[i]->arg);
	  break;

	case 2:
	  printf("%d : ContinuÈ %s(%s)\n",etat_tableau[i]->pid,etat_tableau[i]->commande,etat_tableau[i]->arg);
	  break;

	case 1:
	  printf("%d : En cours %s(%s)\n",etat_tableau[i]->pid,etat_tableau[i]->commande,etat_tableau[i]->arg);
	  break;
	  
	case 0:
	  printf("%d : TerminÈ %s(%s)\n",etat_tableau[i]->pid,etat_tableau[i]->commande,etat_tableau[i]->arg);
	  break;
	  
	}
    }
  printf("\n");
}

int reste_commande()
{
  int i;
  
  for (i=0;i<NCOMMANDES;i++)
    {
      if(etat_tableau[i]->etat)
	return 1;
    }
  return 0;
}

void timer()
{
 struct itimerval time;
  time.it_interval.tv_sec=0;
  time.it_interval.tv_usec=500000;
  time.it_value.tv_sec=0;
  time.it_value.tv_usec=500000;
  setitimer(ITIMER_REAL,&time,NULL);
}

void handler_sig(int sig){
  afficher_etat();
  perror(strerror(errno));
}

int
main(int argc, char *argv[])
{
  pid_t cpid, w;
  int status;
  
  int i;

  /* changement de handler pour sigalarm pour le main*/
      struct sigaction act_sigalarm;
      act_sigalarm.sa_handler= handler_sig;
      sigemptyset(&act_sigalarm.sa_mask);
      act_sigalarm.sa_flags=0;
      sigaction(SIGALRM,&act_sigalarm,NULL);

  /*changement de handler pour sigchld 
  struct sigaction act_sigchld;
  act_sigchld.sa_handler = handler_sig;
  sigemptyset(&act_sigchld.sa_mask);
  act_sigchld.sa_flags=0;
  sigaction(SIGCHLD,&act_sigchld,NULL);*/
  
  /* Lancement */
  for(i=0; i < NCOMMANDES; i++)
    {
      cpid = fork();
      if (cpid == -1) {
	perror("fork");
	exit(EXIT_FAILURE);
	
      }

      
      if (cpid == 0) {  
	execvp(commandes[i][0],commandes[i]);
	perror("execvp");
	abort();
      } 
      
      etat_tableau[i]=malloc(sizeof(struct etat));
      etat_tableau[i]->pid=cpid;
      strcpy(etat_tableau[i]->commande,commandes[i][0]);
      strcpy(etat_tableau[i]->arg,commandes[i][1]);
      etat_tableau[i]->etat=1; /* en cours */
    }
  
  /* Analyse */
  timer();
  while(reste_commande())
    {
      w = waitpid(0, &status, WUNTRACED | WCONTINUED /*| WNOHANG*/);
      printf("retour de wait : %d \n", w);

      if (w > 0) {
	for(i=0; i < NCOMMANDES ; i++)
	  if(etat_tableau[i]->pid == w) 
	    break;
     
	if (WIFEXITED(status)) {
	etat_tableau[i]->etat=0; 
	} else if (WIFSIGNALED(status)) {
	  etat_tableau[i]->etat=0; 
	} else if (WIFSTOPPED(status)) {
	  etat_tableau[i]->etat=3; 
	} else if (WIFCONTINUED(status)) {
	  etat_tableau[i]->etat=2; 
	}
      }
      afficher_etat();
	/*sleep(1); */
    }
  
  afficher_etat();
  printf("Tous les processus se sont termin√©s !\n");
  
  exit(EXIT_SUCCESS);
}
