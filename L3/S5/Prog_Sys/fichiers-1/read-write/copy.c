#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>

void 
perror_and_exit_whenever(int assertion)
{
  if (assertion)
    {
      perror("");
      exit(EXIT_FAILURE);
    }
}

int 
main(int argc, char **argv)
{
  int power;
  size_t buffer_size;
 
  if (argc != 4)
    {
      fprintf(stderr,"%s : <input file name>"
	      " <output filename> <log2 of buffer length> \n", argv[0]);
      return EXIT_FAILURE;
    }
  
  power = strtoul(argv[3], NULL, 10);
  buffer_size = 1 << power;

  char buffer[buffer_size];
  int size_read=1;
  int fd_in= open(argv[1], O_RDONLY);
  int fd_out= open(argv[2], O_SYNC|O_CREAT, 0666);

  while(size_read!=0){
    size_read= read(fd_in, buffer, buffer_size);
    write(fd_out, buffer, size_read);
  }
  

  
  
  return EXIT_SUCCESS;
}
