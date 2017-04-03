#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "tp1.h"


// Pour chacune des quatre fonctions suivantes on supposera que le
// paramètre R est un nombre de taille suffisante pour recevoir le
// résultat de l'opération. On supposera aussi que les opérandes X et
// Y représentent des nombres valides (au moins 1 chiffre, pointeur
// non NULL, etc.). C'est donc à l'appellant de s'en assurer, pas la
// fonction. Les opérandes X,Y sont considérés positifs. Attention !
// Il est possible que X et Y ne soient pas de la même taille.


// calcule R = X+Y en O(n)
void number_addition(number *R, number *X, number *Y){
  int ind_r =0;
  number* n_min = (Y->n < X->n ? Y : X);
  number* n_max = (Y->n >= X->n ? Y : X);
  short res;
  short retenue = 0 ;

  for(int i = 0; i < n_min->n ; ++i){
    res = Y->digit[i] + X->digit[i] + retenue; // Addition chiffre par chiffre
    retenue = res >= BASE ? 1 : 0;
    R->digit[ind_r] = res % BASE;
    ind_r ++;
  }

  //Ajout des chiffres restant dans le plus long nombre
  if(n_min->n < n_max->n){
    for (int i = n_min->n; i< n_max->n; ++i){
      res = n_max->digit[i] + retenue; // Addition chiffre par chiffre
      retenue = res >= BASE ? 1 : 0;
      R->digit[ind_r] = res % BASE;
      ind_r ++;
      }
  }
  //Ajout de la retenue à la fin
  if(retenue != 0)
    R->digit[ind_r] = retenue ;
    

  return;
}


// calcule R = X-Y en O(n), en supposant que X>=Y
void number_substraction(number *R, number *X, number *Y){

  short retenue = 0, res;
  for(int i=0; i < Y->n ; ++i){
    res = X->digit[i] - (Y->digit[i] + retenue);
    retenue = res < 0 ? 1 : 0;
    R->digit[i] = res < 0 ? res + BASE : res ;
  }

  if(X->n > Y->n){
    for(int i = Y->n; i < X->n; ++i){
      res = X->digit[i] - retenue;
      retenue = res < 0 ? 1 : 0;
      R->digit[i] = res < 0 ? res + BASE : res;
    }
  }

    /*if(retenue != 0)
      R->digit[X->n] = retenue;*/
      
  return;
}


// calcule R = X*Y selon la méthode standard en O(n^2)
void number_mul_standard(number *R, number *X, number *Y){

  number *tab_res[X->n];

  //O(n)
  for(int i = 0; i< X->n; ++i){
    tab_res[i] = number_new(10); //Je suppose 10 assez grand pour que le resultat d'une multiplication puisse rentrer
    *tab_res[i]->digit =  X->digit[i] * (*Y->digit);
  }
  
  //O(n)
  for(int i = 0; i < X->n; ++i){
    R->digit[i] += (*tab_res[i]->digit);
    number_free(tab_res[i]);
  }
    
  return;
}


// calcule R = X*Y selon la méthode récursive en O(n^2)
void number_mul_recursive(number *R, number *X, number *Y){

  if(X->n == 1 || Y->n == 1){
   *R->digit = (*X->digit) * (*Y->digit);
   return;
  }
  
  int m = max(X->n, Y->n) / 2; 

  number* x_plus = number_new(X->n - m);
  number* x_moins = number_new(m);
  number* y_plus = number_new(Y->n - m);
  number* y_moins = number_new(m);

  number* p1 = number_new(10); //Je suppose 10 assez grand pour contenir un resultat
  number* p2 = number_new(10);
  number *p3 = number_new(10);
  number *p4 = number_new(10);

  number_mul_recursive(p1,x_plus,y_plus);
  number_mul_recursive(p2,x_plus,y_moins);
  number_mul_recursive(p3,x_moins,y_plus);
  number_mul_recursive(p4,x_moins,y_moins);

  short a = *p1->digit + *p2->digit;
  
  *R->digit = ((*p1->digit*(BASE^(2*m))) + (a*(BASE^m))+ *p4->digit);
  
  return;
}


// calcule R = X*Y selon la méthode de Karastuba en O(n^1.59)
void number_mul_karastuba(number *R, number *X, number *Y){
  return;
}


int main(int argc, char *argv[]){
  
  srandom(time(NULL));
  BASE=2; // base par défaut

  if(argc==2){
    //
    // partie à ne pas modifier
    //
    number X,Y;
    void (*f)(number*,number*,number*);
    switch(read(argv[1],&X,&Y)){ // lit le fichier
    case 'a': f=number_addition;      break;
    case 's': f=number_substraction;  break;
    case 'm': f=number_mul_standard;  break;
    case 'r': f=number_mul_recursive; break;
    case 'k': f=number_mul_karastuba; break;
    default: printf("Unknown operator.\n"); exit(1);
    }
    number *R=number_new(2*max(X.n,Y.n));
    f(R,&X,&Y); // teste l'opération
    write(R,'\n'); // affiche le résultat
    number_free(R);
    return 0;
  }

  if(argc==5){
    //
    // partie à ne pas modifier
    //
    BASE=atoi(argv[1]);
    printf("%hd %s\n",BASE,argv[2]);
    write(number_random(atoi(argv[3])),'\n');
    write(number_random(atoi(argv[4])),'\n');
    return 0;
  }
  
  // pour vos tests personnels, si nécessaire, modifier le main()
  // seulement ci-dessous
  
  ;;;;
  ;;;;
  ;;;;
  
  return 0;
}
