#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <ctype.h>
#include "tp2.h"

paire PPPP(point* px, point* py, int size);

// fonction de comparaison (à completer ...) des abscisses de deux
// points A et B: renvoie -1 si "A<B", +1 si "A>B" et 0 sinon
int fcmp_x(const void *A, const void *B){
  point *p1 = (point*) A;
  point *p2 = (point*) B;

  if(p1->x < p2->x)
    return -1;
  if(p2->x < p1->x)
    return 1; 
  
  return 0;
}


// fonction de comparaison (à completer ...) ordonnées de deux points
// A et B: renvoie -1 si "A<B", +1 si "A>B" et 0 sinon
int fcmp_y(const void *A, const void *B){
  point *p1 = (point*) A;
  point *p2 = (point*) B;

  if(p1->y < p2->y)
    return -1;
  if(p2->y < p1->y)
    return 1;
  
  return 0;
}


// algorithme naïf en O(n^2)
// on suppose que P contient au moins n>=2 points
paire algo_naif(point *P, int n){
  paire resultat={P[0],P[1]}; //on initialise le résultat avec des valeurs dont on est sur qu'elles existent 
  for(int i =0; i <n ;++i){
    //inutile de faire partir j de 0 car dist(i,j) = dist(j,i)
    for(int j =i+1; j< n; ++j){
      if(dist(P[i],P[j]) < dist(resultat.A,resultat.B)){
	resultat.A = P[i];
	resultat.B = P[j];
      }
    }
  }
     
  return resultat;
}


// algorithme récursif en O(nlogn)
// on suppose que P contient au moins n>=2 points
paire algo_rec(point *P, int n){

  point *P_x = (point*)malloc(sizeof(point) *n);
  point *P_y =  (point*)malloc(sizeof(point) *n);

  memcpy(P_x,P,n);//On copie P dans P_x pour pouvoir trier P_x en fonction des x
  memcpy(P_y,P,n);// On copie P dans P_y pour pouvoir trier P_y en fonction des y

  qsort(P_x, n, sizeof(point),fcmp_x); //On trie P_x en fonctions des x
  qsort(P_y, n,sizeof(point), fcmp_y);//On trie P_y en fonctions des y
  
  paire resultat=PPPP(P_x,P_y,n);
  free(P_x);
  free(P_y);
  return resultat;
}

paire PPPP(point* px, point* py, int size){
  paire res;
  //Cas ou |px| est de 2 ou 3 
  if( size <= 3){
    //Pour ce cas le resultat par défaut est la paire des deux premier points de px
    res.A = px[0];
    res.B = px[1];
    if(size >2) {
      if(dist(px[2], px[1]) < dist(px[0],px[1])){
	if(dist(px[2], px[1]) < dist(px[0],px[2])){
	  res.A = px[2];
	  res.B = px[1];
	}
      }
      else{
	if(dist(px[0], px[2]) < dist(px[0],px[1])){
	  if(dist(px[0],px[2]) < dist(px[2],px[1])){
	    res.A = px[0];
	    res.B = px[2];
	  }
	}
      }
    }
    return res;
  }

  //On récupére le point median par rapport  à px
  int ind_median = size % 2 ? (size+1)/2 : size/2;
  double x_median = px[ind_median].x;

  point *A_x =  (point*)malloc(sizeof(point) *size);
  point *A_y =  (point*)malloc(sizeof(point) *size);
  point *B_x =  (point*)malloc(sizeof(point) *size);
  point *B_y =  (point*)malloc(sizeof(point) *size);

  //On construit les tableaux Ax Ay Bx By
  memcpy(A_x,px,ind_median);
  memcpy(A_y,py,ind_median);
  memcpy(B_x,&px[ind_median], size - ind_median);
  memcpy(B_y,&py[ind_median], size - ind_median);

  //On récupére la paire de points la plus proche dans Ax Ay
  paire AAprime = PPPP(A_x,A_y,ind_median);
  //On récupére la paire de points la plus proche dans Bx By
  paire BBprime = PPPP(B_x,B_y, size - ind_median);

  //On calcule la distance de ces plus petite paires
  int distAAprime = dist(AAprime.A, AAprime.B);
  int distBBprime = dist(BBprime.A, BBprime.B);

  //On recupére le delta
  int delta = distAAprime < distBBprime ? distAAprime : distBBprime;
  
  point S_y[size];
  int size_sy =0;
  paire min_si_sy;

  //On récupére les points dont la distance des x est inférieur au delta dans py
  for(int i =0; i< size; i++){
    if( i != ind_median)
      if((x_median - py[i].x) < delta){
	S_y[size_sy] = py[i];
	size_sy ++;
      }
  }

  //On calcule le min Sy
  min_si_sy.A = S_y[0];
  min_si_sy.B = S_y[1];
  for(int i = 0; i< size_sy ; i++)
    for(int j=0; j <= 7; j++){
      if(i+j < size_sy){
	if(dist(S_y[i],S_y[j+i]) < dist(min_si_sy.A,min_si_sy.B)){
	  min_si_sy.A = S_y[i];
	  min_si_sy.B =S_y[i+j];
	}
      }
    }

  //On récupére la plus petite distance entre min_si_sy AAprime et BBprime
  if(dist(min_si_sy.A,min_si_sy.B)< dist(AAprime.A, AAprime.B)){
    if(dist(min_si_sy.A,min_si_sy.B)< dist(BBprime.A, BBprime.B))
      res = min_si_sy;
  }
  else{
    if(dist(BBprime.A,BBprime.B) < dist(AAprime.A,AAprime.B)){
      if(dist(BBprime.A,BBprime.B) < dist(min_si_sy.A,min_si_sy.B))
	res = BBprime;
    }
    else
      res = AAprime;
  }

  //Libération mémoire 
  free(A_x);
  free(A_y);
  free(B_x);
  free(B_y);

  //renvoie toujours 0 car AAprime BBprime et min_si_sy sont toujours à 0
  return res;
}


int main(int argc, char *argv[]){
  
  srandom(time(NULL));

  if(argc==2){
    //
    // partie à ne pas modifier
    //
    if(!isdigit(argv[1][0])){ printf("Forgot \"naif\" or \"rec\"?.\n"); exit(1); }
    int n=atoi(argv[1]);
    point *P=point_random(n);
    if((P==NULL)||(n<1)){ printf("Empty point set.\n"); exit(1); }
    printf("%i\n",n);
    for(int i=0;i<n;i++)
      printf(FORM" "FORM"\n",P[i].x,P[i].y);
    return 0;
  }
    
  if(argc==3){
    //
    // partie à ne pas modifier
    //
    int n;
    paire res={{-1,0},{0,0}};
    point *P=read(argv[1],&n);
    if(!strcmp(argv[2],"naif")) res=algo_naif(P,n);
    if(!strcmp(argv[2],"rec")) res=algo_rec(P,n);
    if(res.A.x<0){ printf("Unknown algorithm.\n"); exit(1); }
    printf("point A: "FORM" "FORM"\n",res.A.x,res.A.y);
    printf("point B: "FORM" "FORM"\n",res.B.x,res.B.y);
    printf("distance: "FORM"\n",dist(res.A,res.B));
    return 0;
  }

  // pour vos tests personnels, si nécessaire, modifier le main()
  // seulement ci-dessous
  
  ;;;;
  ;;;;
  ;;;;
  
  return 0;
}
