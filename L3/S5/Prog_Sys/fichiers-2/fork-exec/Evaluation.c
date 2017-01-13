#include "Shell.h"
#include "Evaluation.h"

#include <stdio.h>
#include <sys/wait.h>
#include <errno.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/types.h>
#include <unistd.h>

void
verifier(int cond, char *s)
{
  if (!cond)
    {
      perror(s);
      exit(1);
    }
}

void executer_simple(char **argv, int bg, char *file, int sortie){
  
  int pid= fork();
  if(!pid){
    //faire redirection de fichier
    if(file!= NULL){
      int fd= open(file, O_TRUNC|O_CREAT|O_WRONLY, 0666);
      verifier(fd, strerror(errno));
      int save= dup(1);
      if(sortie ==1)
	verifier(dup2(fd,1), "dup2");
    }
    //execution de la commande tapé
    verifier(execvp(argv[0], argv), strerror(errno));
  }
  if(!bg){ //si il y a bg le pere ne doit pas attendre pour bloquer le reste 
    waitpid(pid,&status, 0);
  }
  
}

int evaluer_expr(Expression *e)
{
  int bg=0;
  char *redir;
  int sortie;

  if( e->type == BG){
    bg=1;
    e= e->gauche;
  }
  if(e->type == REDIRECTION_O){
    redir= e->arguments[0];
    e= e->gauche;
    sortie =1;
  }
  if(e->type == SIMPLE){
    executer_simple(e->arguments, bg, redir, sortie);
  }
  
  return 1;
}
