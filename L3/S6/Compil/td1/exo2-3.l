%{
#include<stdio.h>
#include<stdlib.h>
int pos = 0;
int ligne =0;
int cartot=0;
//printf("Ligne %d :", ligne);
%}
%%
cabbb {printf("(%d,0)", pos); pos+=2;yyless(2);}
bbc {printf("(%d,1)",pos); pos+=1;yyless(1);}
. {pos++;}
\n {printf("\nLigne %d :", ++ligne);cartot+=pos; pos =0;}
<<EOF>> {return(0);}
%%

// Partie Fonction

int main(){
 yylex();
 printf("%d caracter lu\n", cartot);
}
