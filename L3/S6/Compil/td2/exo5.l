%{
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>
#include <fcntl.h>
#define _GNU_SOURCE 
int fd;

%}

NOTVAR [while|do|if|then|else]
AFFECTATION [":="]
OPERATEUR ["+"|"*"|"-"|"/"]
SEP [";"|" "|":"]|{OPERATEUR}|{AFFECTATION}
TYPE "int"|"bool"|"char"
VAR [a-zA-Z][a-zA-Z0-9\-\_]*
DEBUTCOMMENTAIRE "/*"
FINCOMMENTAIRE "*/"

%s COSINUS
%%

<INITIAL>{DEBUTCOMMENTAIRE} {BEGIN COSINUS;}
<INITIAL>.|\n {write(fd,yytext,yyleng);}
<COSINUS>{FINCOMMENTAIRE} {BEGIN INITIAL;}
<COSINUS>.|\n {;}

<<EOF>> {return 0;}

%%

int main(int argc, char** argv){
fd = open("codesansdebug.c",O_TRUNC|O_CREAT|O_WRONLY,0666);
yylex();
close(fd);
return 0;
}

