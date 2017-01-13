#define _POSIX_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>


int fd0, fd1;

void envoyer(char *msg)
{
  int n = strlen(msg) + 1;
  write(STDOUT_FILENO, &n, sizeof(int));
  write(STDOUT_FILENO, msg, n);
}

void fils0(void)
{
  envoyer("coucou !"); kill(getppid(), SIGUSR1);
  //sleep(1);
  envoyer("Ã§a va ?"); kill(getppid(), SIGUSR1);

  //sleep(1);
  //kill(getppid(), SIGUSR1);
}

void fils1(void)
{
  envoyer("salut !"); kill(getppid(), SIGUSR2);

  //sleep(1);
  // kill(getppid(), SIGUSR2);
}

int recevoir(int fd, char *buf)
{
  int n;

  if(read(fd, &n, sizeof(int)) != sizeof(int))
    return -1;

  read(fd, buf, n);
  return 0;
}

void traitant(int sig)
{
  char buf[1024];
  int num = (sig == SIGUSR1) ? 0 : 1;
  int fd;

  fd = num ? fd1 : fd0;

  if(recevoir(fd, buf) == 0)
    printf("Fils %d: %s\n", num, buf);
  else
    if(num) fd1 = -1; else fd0 = -1;
}

void entrelacer(void)
{
  while (fd0 != -1 || fd1 != -1)
    pause();
}

int main(int argc, char *argv[])
{
  pid_t pid;
  int tube[2];
  struct sigaction sa;

  sa.sa_handler = traitant;
  sigemptyset(&sa.sa_mask);
  sa.sa_flags = 0 ; // SA_NOMASK;
  sigaction(SIGUSR1, &sa, NULL);
  sigaction(SIGUSR2, &sa, NULL);

  pipe(tube);

  pid = fork();

  if(pid == 0) { /* fils 0 */
    dup2(tube[1], 1);
    close(tube[0]);
    close(tube[1]);

    fils0();

    exit(0);
  }

  fd0 = tube[0];
  close(tube[1]);
  
  pipe(tube);

  pid = fork();

  if(pid == 0) { /* fils 1 */
    close(fd0);
    dup2(tube[1], 1);
    close(tube[0]);
    close(tube[1]);

    fils1();

    exit(0);
  }

  fd1 = tube[0];
  close(tube[1]);

  entrelacer();

  return 0;
}
