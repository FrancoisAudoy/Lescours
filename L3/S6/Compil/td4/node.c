#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <inttypes.h>
#include "node.h"
#include "environ.h"


node* node_create(typenode type, char* info, node* filsgauche, node*filsdroit, node* dernierfils){
  node* new_node = (node*)malloc(sizeof(node));

  new_node->type = type;
  new_node->data = info;
  new_node->fils[0]= filsgauche;
  new_node->fils[1]= filsdroit;
  new_node->fils[2]= dernierfils;
  new_node->nouveau = false;
  
  return new_node;
}


/*
 *Libération de l'arbre par récurence en partant de la racine
 * (on suppose que l'on nous passe la racine et qu'elle est non nulle)
 */

void liberer_arbre(node* racine){
  if(racine->type == OP){
     if(racine->fils[0] != NULL)
      liberer_arbre(racine->fils[0]); // Libération du fils gauche
     if(racine->fils[1] != NULL)
      liberer_arbre(racine->fils[1]); // Libération du fils droit
     if(racine->fils[2] != NULL)
      liberer_arbre(racine->fils[2]); // Libération du dernier fils
  }
  
  free(racine);
}

/*
 * Ecriture sur la sortie standard de l'arbre par récurence en partant de la racine
 * (on suppose que l'on nous passe la racine et qu'elle est non nulle)
 */

void ecrire_arbre(node* racine){
  printf("%s ", racine->data);
  if(racine->type == OP){
    if(racine->fils[0] != NULL)
      ecrire_arbre(racine->fils[0]);
    if(racine->fils[1] != NULL)
      ecrire_arbre(racine->fils[1]);
     if(racine->fils[2] != NULL)
      ecrire_arbre(racine->fils[2]);
  }
  return;
}

bool est_nouveau(node* noeud){
  return noeud->nouveau;
}

int numcst = 0;
void remplir_env(ENV e, node* racine){
  char* ct = "CT";
 
  char* ctnumcst = (char*)malloc(sizeof(char) * numcst+1);
  if (racine->type == VAR){
    if(e != NULL && rech(racine->data, e) == NULL){
      racine->nouveau = true;
      initenv(&e,racine->data);
      //printf("%s nouveau \n", racine->data);
    }
  }
  if(racine->type == CST){
    printf("constante %s\n", racine->data);
    sprintf(ctnumcst, "%s%d",ct,numcst);
    numcst++;
    initenv(&e,ctnumcst);
    affect(e,ctnumcst,strtoimax(racine->data,NULL,10));
  }
  else{
    if(racine->type == OP){
      if(racine->fils[0] != NULL)
	remplir_env(e, racine->fils[0]);
      if(racine->fils[1] != NULL)
	remplir_env(e,racine->fils[1]);
      if(racine->fils[2] != NULL)
	remplir_env(e,racine->fils[2]);
    }
  }
}
