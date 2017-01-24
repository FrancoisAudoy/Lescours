#include <GL/glu.h>
#include <SDL2/SDL.h>
#include <SDL2/SDL_opengl.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <float.h>
#include "utils.h"
#include "variables.h"

#include "misc.c"

// Génère des points aléatoires dans le rectangle [0,max_X] × [0,max_Y]
static point* generatePoints(int n, int max_X, int max_Y) {
	point *V = malloc(n * sizeof(point));
	double ratio_x = (double) max_X / RAND_MAX;
	double ratio_y = (double) max_Y / RAND_MAX;
	for (int i = 0 ; i < n ; i++) {
		V[i].x = rand() * ratio_x;
		V[i].y = rand() * ratio_y;
	}
	return V;
}

/* ============ Programmation Brute Force ============= */ 
static double dist(point p1, point p2) {
  double x = pow(p1.x- p2.x, 2);
  double y = pow(p1.y - p2.y , 2); 
  return sqrt(x+y);
}

static double value(point *V, int n, int *P) {
  double val = 0;
  for (int i = 0; i< n; ++i)
    val+= dist(V[P[i]], V[P[(i+1)%n]]);
	return val;
}

static double tsp_brute_force(point *V, int n, int *P) {
  int * Q = (int * ) malloc(n*sizeof(int));
  for(int i =0; i<n; ++i)
    Q[i] = i;
  double dist_mini = value(V,n,Q), tmp_val;
  while (NextPermutation(Q,n)){
    tmp_val = value(V,n,Q);
    if( tmp_val < dist_mini){
      dist_mini= tmp_val;
      memcpy(P,Q, n * sizeof(int));
    }
  }
  free(Q);
  return dist_mini;
}

static double value_opt(point *V, int n, int * P, int w){
  double val =0;
  int k=1 ;
  for (int i=0; i<n-1 ; ++i,k++){
    val += dist(V[P[i]], V[P[i+1]]);
    if( (val + dist(V[P[i+1]], V[P[0]])) > w)
      return (double)k * -1;
  }
  return (val + dist(V[P[n-1]], V[P[0]])) ;
}

static void MaxPermutation(int *P, int n, int k){
  int tmp, i=1;
  while( k < n-i){
    tmp = P[k];
    P[k] = P[n-i];
    P[n-i] = tmp;
    ++i;
    ++k;
  }
}

static double tsp_brute_force_opt(point *V,int n,int *P){
  int * Q = (int *) malloc(n * sizeof(int));
  for(int i = 0; i< n; ++i)
    Q[i] = i;

  double dist_mini = value(V,n,Q);
  double tmp;
  while(NextPermutation(Q,n)){
    tmp = value_opt(V,n,P,dist_mini);
    if (tmp < 0) 
      MaxPermutation(Q,n,abs(tmp));
    else
      if ( tmp < dist_mini){
      dist_mini = tmp;
      memcpy(P,Q, n * sizeof(int));
    }
  }
  free(Q);
  return dist_mini;
}

/* ==== Programmation dynamique ====*/

static void drawPath(point *V, int n, int *path, int len);

static int NextSet(int S, int n){
/*
  Renvoie le plus petit entier immédiatement supérieur à S>0 et qui a
  soit le même poids que S, c'est-à-dire le même nombre de 1 dans son
  écriture binaire que S, soit le poids de S plus 1 s'il n'y en a pas
  de même poids. La fonction renvoie 0 si S est le plus grand entier
  sur n bits, soit S=2^n-1.

  L'algorithme est le suivant: dans S on décale complètement à droite
  le premier bloc de 1 (celui contenant le bit de poids faible) sauf
  le bit le plus à gauche de ce bloc qui lui est décalé d'une position
  à gauche. Si on ne peut pas décaler ce bit plus à gauche c'est que
  ou bien on est arrivé à 2^n-1 (et on renvoie 0) ou bien on doit
  passer à un poids plus élevé. Dans ce cas on renvoie 2^p-1 où p est
  le nouveau nombre de 1 de S plus 1.

  Résultats obtenus en itérant S -> NextSet(S,4) à partir de S=1:
   (taille 1) S = 0001 -> 0010 -> 0100 -> 1000 ->
   (taille 2)     0011 -> 0101 -> 0110 -> 1001 -> 1010 -> 1100 ->
   (taille 3)     0111 -> 1011 -> 1101 -> 1110
   (taille 4)     1111 ->
   (taille 0)     0000

  Ainsi, les 16 entiers sur n=4 bits sont parcourus dans l'ordre: 1 ->
  2 -> 4 -> 8 -> 3 -> 5 -> 6 -> 9 -> 10 -> 12 -> 7 -> 11 -> 13 -> 14
  -> 15 -> 0

  L'algorithme prend un temps O(1) car les opérations de shifts (<<)
  et la fonction ffs() sur des int correspondent à des instructions
  machines sur des registres.
*/
  int p1 = ffs(S); // position du bit le plus à droit (commence à 1)
  int p2 = ffs(~(S >> p1)) + p1 - 1; // position du bit le plus gauche du 1er bloc de 1
  if (p2 - p1 + 1 == n) return 0; // cas S=2^n-1
  if (p2 == n) return (1 << (p2 - p1 + 2)) - 1; // cas: poids(S)+1
  return (S & ((-1) << p2)) | (1 << p2) | ((1 << (p2 - p1)) - 1); // cas: poids(S)
}

#define IN_SET(S,i)  ((S) & (1 << (i))) // est-ce que i est dans S ?
#define ADD_SET(S,i) (S | (1 << (i)))   // ajoute i à S
#define DEL_SET(S,i) (S & ~(1 << (i)))  // supprimer i de S

/* une cellule de la table */
typedef struct{
  double cost; // coût du chemin minimum D[t][S]
  int pred;    // point précédant t dans la solution D[t][S]
} cell;

static double tsp_prog_dyn(point *V, int n, int *Q){
/*
  Version programmation dynamique du TSP. Le résultat doit être écrit
  dans la permutation Q. On renvoie la valeur de la tournée minimum ou
  -1 s'il y a eut une erreur (pression de 'q' pour sortir de
  l'affichage).  Une fois que votre programme arrivera à calculer une
  tournée optimale (à comparer avec tsp_brute_force()), il sera
  intéressant de dessiner à chaque fois que possible le chemin courant
  avec drawPath().

  Attention ! Par rapport au cours, il est plus malin de commencer la
  tournée à partir du point d'indice n-1 (au lieu de 0). Pourquoi ?

  Pour résumer:

  - D[t][S].cost = coût minimum d'un chemin allant de V[n-1] à V[t]
    qui visite tous les points d'indice dans S

  - D[t][S].pred = l'indice du point précédant V[t] dans le chemin
    ci-dessus de coût D[t][S].cost
*/

  int t,S, St;
  
  // déclaration de la table D[t][S] qui comportent (n-1)*2^(n-1) cellules
  cell **D = malloc((n-1)*sizeof(cell*)); // n-1 lignes
  for(t=0; t<n-1; t++) D[t] = malloc((1<<(n-1))*sizeof(cell)); // 2^{n-1} colonnes

  // si Q n'est pas alloué, c'est peut-être le bon moment pour le
  // faire ici ...
  if (Q == NULL) {
    Q = (int *) malloc(sizeof(int) * n) ;
    for (int i=0; i<n; ++i)
      Q[i] = i;
  }
  
  // cas de base, lorsque S={t}, pour t=0..n-2: D[t][S]=d(V[n-1],V[t])
  S=1; // S=...0001 et pour l'incrémenter utiliser NextSet(S,n-1)
  for ( t=0 ; t < n-1; ++t){
    D[t][S].cost = dist(V[n-1],V[t]);
    D[t][S].pred = n-1 ;
    S = NextSet(S,n-1);
  }
  


  // cas |S|>1: D[t][S] = min_x { D[x][S\{t}] + d(V[x],V[t]) }
  // avec t dans S et x dans S\{t}
  double min;
  int tmp, x, minpred;
  do{
    for( t=0; t< n-1; ++t){
      if (IN_SET(S,t)){
	min = DBL_MAX;
        St = DEL_SET(S,t);
	for( x = 0; x<n ; ++x){
	  if(IN_SET(St,x))
	    if(min > (tmp =(D[x][St].cost + dist(V[x],V[t])))){
	      minpred= x;
	      min = tmp;
	    }  
	}
	D[t][S].cost = min;
	D[t][S].pred = minpred;
      }
    }

    // ici D[t][S].cost et D[t][S].pred viennent d'être calculés
    // décommenter la suite pour dessiner le chemin partiel qui
    // est construit en partant de V[t] et en remontant jusqu'à V[n-1]
    //
     St=S;
     Q[0]=t;  // écrit le dernier point connu
     int k=1; // k=taille de Q=nombre de points écrits dans Q
     while(Q[k-1]!=n-1){
      Q[k] = D[Q[k-1]][St].pred;
      St=DEL_SET(St,Q[k-1]);
      k++;
     }
    drawPath(V, n, Q, k);
    
  }while ((S = NextSet(S, n-1)) && running);

  double w=-1; // valeur de la tournée optimale, -1 par défaut
  
  if(running){
    // on a terminé correctement le calcul complet de la table D. Il
    // faut alors calculer le coût w de la tournée optimale et
    // éventuellement construire la tournée pour la mettre dans Q. NB:
    // si le calcul a été interrompu (pression de 'q' pendant
    // l'affichage) alors ne rien faire et renvoyer -1
    
    w = DBL_MAX;
    int tmp2;
    for (int t = 0 ; t< n-1; ++t){
      if(w > (tmp = D[t][S].cost + dist(V[t], V[n-1]))){
	w = tmp;
	tmp2 = t;
      }
    }
    St= (1<<(n-1))-1;
    Q[0]=tmp2;  // écrit le dernier point connu
    int k=1; // k=taille de Q=nombre de points écrits dans Q
    while(Q[k-1]!=n-1){
      Q[k] = D[Q[k-1]][St].pred;
      St=DEL_SET(St,Q[k-1]);
      k++;
    }
  }
	
   // pensez à libérer la table D
  for(int i=0; i <n-1; ++i)
    free(D[i]);
  free(D);
  return w; 
}


static void drawPath(point *V, int n, int *path, int len){

  // saute le dessin si le précédent a été fait il y a moins de 20ms
  static unsigned int last_tick = 0;
  if (last_tick + 20 > SDL_GetTicks()) return;
  last_tick = SDL_GetTicks();
  
  // gestion de la file d'event
  handleEvent(false);
  
  // efface la fenêtre
  glClearColor(0,0,0,1);
  glClear(GL_COLOR_BUFFER_BIT);
  
  // dessine le chemin
  selectColor(0,1,0); // vert
  for (int i = 0 ; i < len-1 ; i++)
    drawLine(V[path[i]], V[path[i+1]]);
  
  // dessine les points
  selectColor(1,0,0); // rouge
  for (int i = 0 ; i < n ; i++)
    drawPoint(V[i]);
  
  // affiche le dessin
  SDL_GL_SwapWindow(window);
}

// Taille initiale de la fenêtre
int width = 640;
int height = 480;

bool running = true;
bool mouse_down = false;
double scale = 1.0f;

static void draw(point *V, int n, int *P) {
	// Efface la fenêtre
	glClearColor(0,0,0,1);
	glClear(GL_COLOR_BUFFER_BIT);

	// Dessin …
	// Choisir la couleur blanche
	if(P){
	  selectColor(1.0f, 1.0f, 1.0f);
	  for (int i = 0 ; i < n ; i++)
	    drawLine(V[P[i]], V[P[(i+1) % n]]);
	}
	// Rouge
	selectColor(1.0f, 0.0f, 0.0f);
	for (int i = 0 ; i < n ; i++)
		drawPoint(V[i]);

	handleEvent(false);

	// Affiche le dessin
	SDL_GL_SwapWindow(window);
}

int main(int argc, char *argv[]) {

	initSDLOpenGL();
	srandom(time(NULL));
	TopChrono(0); // initialise tous les chronos
	
	bool need_redraw = true;
	bool wait_event = true;

	int n = 24;
	int X = 300, Y = 200;
	point *V = generatePoints(n, X, Y);
	int *P = malloc(n * sizeof(int));
	for (int i = 0 ; i < n ; i++) P[i] = i;
	draw(V, n, NULL); // dessine les points
	
	/*TopChrono(1); // départ du chrono 1
	double w = tsp_brute_force(V,n,P);
	char *s = TopChrono(1); // s=durée
	printf("value: %g\n",w);
	printf("runing time: %s\n",s);
	draw(V, n, P); // dessine la tournée*/
	
	/*for (int i = 0 ; i < n ; i++) P[i] = i;
	TopChrono(1); // départ du chrono 1
	double w2 = tsp_brute_force_opt(V,n,P);
	char *s2 = TopChrono(1); // s=durée
	printf("value: %g\n",w2);
	printf("runing time: %s\n",s2);
	draw(V, n, P); // dessine la tournée*/

	for(int i =0; i<n; ++i) P[i] = i;
	TopChrono(1);
	double w3 = tsp_prog_dyn(V,n,P);
	char *s3 = TopChrono(1);
	printf("value: %g\n",w3);
	printf("runing time: %s\n",s3);
	draw(V, n, P); // dessine la tournée
	
	// Affiche le résultat (q pour sortir)
	while (running) {

		if (need_redraw)
			draw(V, n, P);

		need_redraw = handleEvent(wait_event);
	}

	// Libération de la mémoire
	TopChrono(-1);
	free(V);
	free(P);

	cleaning();
	return 0;
}
