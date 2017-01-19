%{
#include<stdio.h>
#include<stdlib.h>
int res = 0;
%}
%%
abb {res = 1;}
. | \n {ECHO;}
<<EOF>> {return(res);}
%%

// Partie Fonction

int main(){
 yylex();
 if (res == 0) 
  printf("Pas d'occurence de 'abb'\n");
 else 
  printf("occurence de 'abb'\n");
}
