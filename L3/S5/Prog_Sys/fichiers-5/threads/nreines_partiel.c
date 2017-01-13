#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <stdbool.h>
#include <string.h>
#include <arpa/inet.h>

#define MAX 16

typedef bool echiquier[MAX][MAX];

static bool ok(int n, int ligne, int colonne, echiquier e);

void nreines (int n, int ligne, echiquier e, int *cpt)
{
  for (int col = 0; col < n; col++)
    if (ok (n, ligne, col, e))
    {
      if (ligne == n - 1)
	(*cpt)++;
      else
      {
	e[ligne][col] = true;
	nreines (n, ligne + 1, e, cpt);
	e[ligne][col] = false;
      }
    }
}


static bool
ok (int n, int ligne, int colonne, echiquier e)
{
  int l, c;
  for (l = 0; l < ligne; l++)
    if (e[l][colonne])
      return false;

  for (l = ligne - 1, c = colonne - 1; l >= 0 && c >= 0; l--, c--)
    if (e[l][c])
      return false;

  for (l = ligne - 1, c = colonne + 1; l >= 0 && c <= n; l--, c++)
    if (e[l][c])
      return false;
  return true;
}

void 
usage (char *s)
{
  fprintf (stderr, "%s entier", s);
  exit (EXIT_FAILURE);
}

int main (int argc, char ** argv){
  
  echiquier e;
  int cpt = 0;
  char *endptr;

  if (argc < 2)
    usage (argv[0]);

  int fd = open ("nbsolution.txt", O_RDWR | O_CREAT, 0666);
  
  int n = strtoul (argv[1], &endptr, 10);

  if (*endptr != 0)
    usage (argv[1]);

  for(int i =0; i < n; ++i){
    int pid = fork();
    if(! pid){
      memset (e, 0, sizeof (e));
      e[0][i]=true;
      nreines (n, 1, e, &cpt);
      //      printf("%d\n",cpt);
      lseek(fd, i*sizeof(int), SEEK_SET);
      write(fd, &cpt,sizeof(int));
      break;
    }
  }

  for(int i=0; i<n; ++i)
    wait(NULL);
  
  return EXIT_SUCCESS;
}
