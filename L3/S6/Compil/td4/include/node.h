#ifndef NODE_H
#define NODE_H
//définie le type de noeud
#include <stdbool.h>
#include "environ.h"


typedef enum { OP, VAR, CST} typenode;

typedef struct node {
  typenode type;
  char* data;
  bool nouveau;
  struct node* fils[3]; //fils[0]-> fils droit fils[1]-> fils gauche fils[2] cas pour If then else
} node;



extern node* node_create(typenode type, char* info,node* filsgauche, node* filsdroit, node* dernierfils);
extern void liberer_arbre(node* racine); //Libération de l'arbre par récurence
extern void ecrire_arbre(node* racine);
extern bool est_nouveau(node* noeud);
extern void remplir_env(ENV e, node* racine);

#endif