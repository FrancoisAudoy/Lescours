%{
#include <stdio.h>
#include <stdlib.h>
typedef struct listevar{
char * var;
unsigned int occurence;
struct listevar* suivant;
}listevar;

listevar* tete_liste = NULL;
listevar* finliste = NULL;
char* lu;

listevar* present(char*);
void addvar(char*);
void afficherliste();
void libererliste();
%}

NOTVAR [while|do|if|then|else]
AFFECTATION [:=]
OPERATEUR ["+"|"*"|"-"|"/"]
SEP [";"|" "|"("|")"]|{OPERATEUR}|{AFFECTATION}

VAR [a-zA-Z]+[a-zA-Z0-9\-\_]*{SEP}

%%
<INITIAL>{NOTVAR}+{SEP} {;}
<INITIAL>{OPERATEUR} {;}
<INITIAL>{VAR} {addvar(yytext);}

. {;}
<<EOF>> {afficherliste(); libererliste(); return(0);}

%%

/****** Liste *******/
listevar* present(char * var){
listevar* ret = tete_liste;
while(ret != NULL){
if (!strcmp(ret->var, var))
return ret;
ret = ret->suivant;
}
return NULL;
}

void addvar(char* n_var){
//liste vide
n_var[yyleng-1] ='\0';
if( tete_liste == NULL){
tete_liste = (listevar*)malloc(sizeof(struct listevar));
tete_liste->var = (char*) malloc(sizeof(yyleng));
strcpy(tete_liste->var,n_var);
tete_liste->occurence = 1;
finliste=tete_liste;
}
else{
//liste pas vide 
listevar* element = NULL;
element = present(n_var);
if (element == NULL){
listevar* new_ele = (listevar*)malloc(sizeof(struct listevar));
new_ele->var =(char*) malloc(sizeof(yyleng));
strcpy(new_ele->var,n_var); ;
new_ele->occurence = 1;
new_ele->suivant = NULL;

finliste->suivant = new_ele;
finliste=new_ele;
}
else{
element->occurence ++;
}
}
}

void afficherliste(){
if(tete_liste == NULL){
printf("liste vide\n");
return; }
listevar* curseur = tete_liste;
while(curseur != NULL){
printf("[%s:%d] ", curseur->var, curseur->occurence);
curseur = curseur->suivant;
}
printf("\n");
}

void libererliste(){
listevar* curseur;
while(tete_liste != NULL){
curseur = tete_liste;
tete_liste = tete_liste->suivant;
free(curseur);
}
}

int main(int argc, char ** argv){
yylex();
return 0;

}
