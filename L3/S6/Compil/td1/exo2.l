%{
#include<stdio.h>
#include<stdlib.h>
int res = 0;
%}
%%
cabb {res = 1;}
cbab {res = 1;}
cbb {res = 1;}
cbbba {res = 1;}
.|\n {ECHO;}
<<EOF>> {return(res);}
%%

// Partie Fonction

int main(){
 yylex();
 if (res == 0) 
  printf("Pas d'occurence\n");
 else 
  printf("occurence\n");
}
