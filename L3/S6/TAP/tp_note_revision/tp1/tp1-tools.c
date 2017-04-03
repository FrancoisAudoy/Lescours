#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include "tp1.h"


number *number_new(int n){
  number *t=malloc(sizeof(*t));
  t->n=n;
  t->digit=calloc(n,sizeof(*t->digit));
  return t;
}


void number_free(number *t){
  if(t){
    free(t->digit);
    free(t);
  }
}


char read(char *file, number *X, number *Y){

  // ouvre le fichier
  FILE *f=fopen(file,"r");
  if(f==NULL){ printf("Cannot open file \"%s\"\n",file); exit(1); }

  // lit la base et l'opérateur
  char c;
  fscanf(f,"%hd %c\n",&BASE,&c);
  if((BASE<2)||(BASE>10)){ printf("Incorrect value for the base.\n"); exit(1); }

  char *L=NULL; // L=buffer pour la ligne de texte à lire
  size_t b=0;   // b=taille du buffer L utilisé (nulle au départ)
  ssize_t n;    // n=nombre de caractères lus dans L, sans le '\0'
  int i,j,fois;
  number *t;

  // lit 1er (=X) et 2e (=Y) opérande
  for(fois=1; fois<=2; fois++){ // répète deux fois la même chose
    t=(fois==1)? X : Y; // d'abord avec X, puis Y
    n=getline(&L,&b,f)-1; // lit une ligne, n=nombre de chiffres lus
    if(L[n]=='\n') L[n]='\0';
    t->digit=malloc(n*sizeof(*(t->digit)));
    for(i=n-1, j=0; i>=0; i--){
      if(!isdigit(L[i])) continue; // ne rien faire si pas un nombre
      L[i] -= '0';
      if((L[i]<0)||(L[i]>=BASE)){ printf("Invalid digit.\n"); exit(1); }
      t->digit[j++]=L[i]; // écrit un chiffre
    }
    t->n=j; // j=nombre de chiffres écrits dans digit[]
    if(j<n) t->digit=realloc(t->digit,t->n*sizeof(*(t->digit)));
  }

  fclose(f);
  free(L);
  return c;
}


void write(number *A, char c){
  if((A==NULL)||(A->n==0)){ printf("Empty number.\n"); exit(1); }
  int i=A->n-1,d;

  do d=A->digit[i--]; // enlève les zéros à gauche
  while((i>=0)&&(d==0));
  i++;

  do printf("%hd",A->digit[i--]); // affiche les autres chiffres
  while(i>=0);

  printf("%c",c);
  return;
}


number *number_random(int n){
  if(n<1) return NULL;
  number *R=number_new(n);
  for(--n;n>=0;n--) R->digit[n]=random()%BASE;
  return R;
}
