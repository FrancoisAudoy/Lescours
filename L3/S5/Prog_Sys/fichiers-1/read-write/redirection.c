#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>


void verifier(int i, char *s)
{
  if (!i) {
    perror (s);
    exit (EXIT_FAILURE);
  }
}

void quelques_prints (void)
{
  printf ("Juste");
  printf (" histoire");
  printf (" de tester...\n");
  printf ("...que la redirection");
  printf (" marche !\n");
}

void rediriger_vers (void (*f)(void), char *file)
{
  // A COMPLETER
  int fd=open(file, O_WRONLY|O_CREAT|O_TRUNC, 0666);
  verifier(fd,"open");
  int save = dup(1); //sauvegarde le pointeur de la sortie standard au début
  int check= dup2(fd,1); //la sortie standard pointe sur une autre sortie (un fichier)
  
  verifier(check, "dup2");
  f();
  // close(fd);
  dup2(save,1);//la sortie standard recupere son pointeur de debut
  }

int main(int argc, char *argv[])
{
  printf ("*** DEBUT ***\n");

  rediriger_vers (quelques_prints, "sortie.txt");

  printf ("*** FIN ***\n");

  return EXIT_SUCCESS;
}
  
