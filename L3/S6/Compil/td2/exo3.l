%{
#include <stdio.h>
#include <stdlib.h>
typedef struct listevar{
char * var;
unsigned int occurence;
struct listevar suivant = NULL
}listevar;

listevar* tete_liste = NULL;
listevar* finliste = NULL

bool present(char*,int*);
void addvar(char*);
void compteroccurence();
%}
NOTVAR [while,do,if,then,else]
AFFECTATION [:=]
SEP [";"" "]
VAR [a-z A-Z\_][a-z A-Z 0-9 \-\_]*


%%

int main(int argc, char ** argv){
yylex();
}

addvar(char* n_var){
if( teteliste == NULL){
teteliste = (listevar*)malloc(sizeof(struct listevar));
teteliste->var = n_var;
teteliste->occurence = 1;
finliste=teteliste;
}
else{
int pos;
if (!present(n_var,&pos)){
listevar new_ele = (listevar*)malloc(sizeof(struc listevar));
new_ele->var = n_var;
new_ele->occurence = 1;

finliste->suivant = new_ele;
}
else{
listevar* curseur = teteliste;
for(int i =0; i< pos; ++i)
	curseur = curseur->next;
	curseur->occurence ++;
	}
	}
	}

	
