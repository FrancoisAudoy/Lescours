%{
#include<stdio.h>
#include<stdlib.h>
void test_parite(int);
int ligne =0;
%}
%s q00 q01 q11 q10 
%%
<INITIAL>b {BEGIN q01;}
<INITIAL>a {BEGIN q10;}
<q00>b {BEGIN q01;}
<q00>a {BEGIN q10;}
<q01>b {BEGIN q00;}
<q01>a {BEGIN q11;}
<q11>a {BEGIN q01;}
<q11>b {BEGIN q10;}
<q10>a {BEGIN q00;}
<q10>b {BEGIN q11;}
<q01>\n {test_parite(1);ligne++; BEGIN INITIAL;/* mot valide*/}
<q00,q11,q10>\n {test_parite(0);ligne++;BEGIN INITIAL; /* mot non valide*/}
<<EOF>> {return(0);}
. {;}
%%

// Partie Fonction

int main(){
yylex();
}

void test_parite(int parite){
if (parite)
printf("Ligne %d :ce mot est valide\n", ligne);
else
printf("Ligne %d :ce mot n'est pas valide\n", ligne);
}
