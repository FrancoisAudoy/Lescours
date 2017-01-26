%{
#include<stdio.h>
#include<stdlib.h>
void test_parite();
int ligne =0;
int nbr_a = 0;
int nbr_b = 0;
%}
%%
a {nbr_a++;}
b {nbr_b++;}
. {;}
\n {test_parite(); ligne++;nbr_a=0;nbr_b=0;}
<<EOF>> {return(0);}
%%

// Partie Fonction

int main(){
 yylex();
}

void test_parite(){
if ( (nbr_a%2) == 0 && (nbr_b % 2)!=0)
printf("Ligne %d :ce mot est valide\n", ligne);
else
printf("Ligne %d :ce mot n'est pas valide\n", ligne);
}
