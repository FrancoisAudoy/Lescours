%{
#include <stdio.h>
#include <stdlib.h>
%}
%option yywrap

singulier le|ce|quelque|Le|Ce|Quelque
singulier2 la|un|La|Un
pluriel {singulier}+s
sep [ /t/n","]

%s PLURIEL SINGULIER 
%%
<INITIAL>{pluriel}+{sep} {ECHO;BEGIN PLURIEL;}
<INITIAL>{singulier}+{sep},{singulier2}+{sep} {ECHO;BEGIN SINGULIER;}
<PLURIEL,SINGULIER>(loups|loup)/{sep} {printf("ours"); BEGIN INITIAL;}
<PLURIEL>chamois/{sep} {printf("izards");BEGIN INITIAL;}
<SINGULIER>chamois/{sep} {printf("izard"); BEGIN INITIAL;}
Pralognan {printf("Saint-Girons"); BEGIN INITIAL;}
Alpes {printf("Pyrenees"); BEGIN INITIAL;}
. {printf("%s", yytext);}
<<EOF>> {return(0);}
%%

int main(void){
yylex();
return 0;
}
