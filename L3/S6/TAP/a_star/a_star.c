#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h>
#include <time.h>

#include "variables.h"
#include "utils.h"
#include "heap.h" // il faut aussi votre code pour heap.c


// Une fonction de type "heuristic" est une fonction h() qui renvoie
// une distance (type double) entre une position de départ et de fin
// de la grille. La fonction pourrait aussi dépendre de la grille (on
// ne l'utilisera pas en fait).
typedef double (*heuristic)(position,position,grid);

  

// Heuristique "nulle" pour Dijkstra
double h0(position s, position t, grid G){
  return 0.0;
}

// Heuristique "vol d'oiseau" pour A*
double hvo(position s, position t, grid G){
  return fmax(abs(t.x-s.x),abs(t.y-s.y));
}

// Structure "noeud" pour le tas min Q
typedef struct{
  position pos;        // position (.x,.y) d'un noeud u
  double cost;         // coût[u]
  double f;            // f[u] = coût[u] + h(u,end)
  struct node *parent; // parent[u] = pointeur vers le père, NULL pour start
} node;

// Les arêtes, connectant les cases de la grille, sont valués
// seulement certaines valeurs possibles. Le poids de l'arête u->v,
// noté w(u,v) dans le cours, entre deux cases u et v voisines est
// déterminé par la valeur de la case finale v. Plus précisément, si
// la case v de la grille contient la valeur C, le poids de u->v
// vaudra weight[C] dont les valeurs exactes sont définies ci-après.
// La liste des valeurs possibles d'une case est donné dans
// variables.h: V_ROOM, V_WALL, V_WATER, ... Attention !
// weight[V_WALL]<0. Ce n'est pas une valuation correcte car il n'y a
// pas de sommet en position (i,j) si G.value[i][j] = V_WALL.

double weight[]={
    1.2,  // V_ROOM
  -99.0,  // V_WALL
    3.0,  // V_SAND
    9.0,  // V_WATER
    2.3,  // V_MUD
    1.0,  // V_WIND
};

//Fonction de comparaison des noeuds
int fminimum(const void *a,const void *b){
  node *s= (node*)a;
  node *t= (node*)b;
  return (int) (s->f - t->f);
}

node * node_create(int p_x,int p_y, node* parent, heuristic h, position fin, grid G){
  node * new_node = (node*)malloc(sizeof(node));
  new_node->pos.x = p_x;
  new_node->pos.y = p_y;
  if(parent != NULL)
    new_node->cost = parent->cost + weight[G.value[p_x][p_y]];
  else
    new_node->cost = 0.0;
  position p ={p_x,p_y};
  new_node->f = new_node->cost + h(p, fin, G);
  new_node->parent = parent;

  return new_node;
}

// Votre fonction A_star(G,h) doit construire un chemin dans la grille
// G entre la position G.start et G.end selon l'heuristique h(). S'il
// n'y en a de chemin, affichez un simple message d'erreur. Sinon,
// vous devez remplir le champs .mark de la grille pour que le chemin
// trouvé soit affiché plus tard par drawGrid(G). La convention est
// qu'en retour G.mark[i][j] = M_PATH ssi (i,j) appartient au chemin
// trouvé (cf. "variables.h").
//
// Pour gérer l'ensemble P, servez-vous du champs G.mark[i][j] (=
// M_USED ssi (i,j) est dans P) qui est initialisé à une valeur
// différente par initGrid().
//
// pour gérer l'ensemble Q, vous devez utiliser un tas min de "node"
// avec une fonction de comparaison qui dépend du champs .f des
// noeuds. Pensez que la taille du tas Q est au plus la somme des
// degrés des sommets dans la grille.

void A_star(grid G, heuristic h){
  
  heap q= heap_create(1,fminimum);
  node *noeud =node_create(G.start.x,G.start.y,  NULL, h, G.end, G);
  heap_add(q, (void*)noeud);
  //G.mark[G.start.x][G.start.y];

  while(!heap_empty(q)){
  // Pensez à dessiner la grille avec drawGrid(G) à chaque fois, par
  // exemple, que vous ajouter un sommet à P.
    
  // Après avoir extrait un noeud de Q, il ne faut pas le détruire,
  // sous peine de ne plus pouvoir reconstruire le chemin trouvé. Pour
  // libérer les noeuds de Q avant de sortir, vous pouvez simplement
  // les stocker au fur et à mesure à la fin du tableau représentant
  // le tas ...
    noeud = (node*)heap_pop(q);
    if ( G.mark[noeud->pos.x][noeud->pos.y] != M_USED){
    //La fin a été atteinte, on marque les parents avec M_PATH
    if((noeud->pos.x == G.end.x) && (noeud->pos.y == G.end.y)){
      while((noeud->pos.x != G.start.x) && (noeud->pos.y != G.start.y)){
	G.mark[noeud->pos.x][noeud->pos.y] = G.mark[noeud->pos.x][noeud->pos.y] | M_PATH;
	noeud = noeud->parent;
      }
      return ;
    }

    //Ajout du sommet u dans P
    G.mark[noeud->pos.x][noeud->pos.y] = M_USED;
    drawGrid(G);
   
    for(int x = noeud->pos.x -1; x <= noeud->pos.x+1; ++x)
      for(int y = noeud->pos.y-1; y <= noeud->pos.y+1; y++){
	if(G.value[x][y] != V_WALL && G.mark[x][y] != M_USED){
	  G.mark[x][y] = M_SEEN;
	  heap_add(q, node_create(x,y,noeud,h,G.end,G));
	 }
      }
    }
		   	
  // Les bords de la grille sont toujours constitués de murs (V_WALL) ce
  // qui évite d'avoir à tester la validité des indices des positions
  // (sentinelle).
  ;;;
  }
  fprintf(stderr, "ERROR: ***** Aucun chemin possible\n ");
  return;
  
}


int width = 1920, height = 1080; // dimensions initiale de la fenêtre
bool running = true; // passe à faux lorsqu'on presse 'q' lors d'un dessin
double scale = 1.0; // zoom courrant = nombre de pixels par unité
int delay = 1; // délais d'affichage pour drawGrid(), unité = 10 ms


int main(int argc, char *argv[]){

  srandom(time(NULL));

  delay=2;
  scale=4.0;
  initSDLOpenGL();
  
  int K = 221; // doit être impair
  grid G = initGrid(K,K); // labyrithne aléatoire K x K

  // Pour ajouter des "trous" de différentes types de cases
  // addRandomBlob(G, V_ROOM, 0); // met tout en blanc
  // addRandomBlob(G, V_SAND, K/10);
  // addRandomBlob(G, V_WATER, K/10);

  // Pour choisir G.start et G.end aléatoirement parmi V_ROOM
  // randomPosition(&G, V_ROOM, V_ROOM);

  A_star(G,h0);

  while(running){
    drawGrid(G);
    handleEvent(true);
  }

  freeGrid(G);
  cleaning();

  return 0;
}
