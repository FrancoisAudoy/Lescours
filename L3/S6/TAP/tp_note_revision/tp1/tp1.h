#ifndef TP1_H
#define TP1_H


static inline int max(int x,int y){ return (x>y)?x:y; }
static inline int min(int x,int y){ return (x<y)?x:y; }


// base des nombres, entier >= 2
// NB: le format pour un 'short' est "%hd"
short BASE;


typedef struct{
  int n;        // nombre de chiffres, taille de digit[]
  short *digit; // tableau de chiffres, entier de [0,BASE[, unité = digit[0]
} number;


// alloue un nombre de n chiffres à zéros
extern number *number_new(int n);


// libère un nombre
extern void number_free(number *t);


/*
  Lit un fichier texte (file) de trois lignes contenant une base et
  une opération (ligne 1) ainsi que deux opérandes (ligne 2 et ligne
  3). La base est un entier 'short' de [2,10], l'opération est un
  caractère parmi {'a','s','m','r','k'} (voir ci-après) et chaque
  opérande est une suite de chiffres de [0,BASE[ écrit sur une ligne,
  l'unité étant à droite.
  
  Exemple:

    2 a
    010110
    101

  La valeur de la variable globale BASE est modifiée, X et Y sont les
  deux opérandes, et la valeur de retour de la fonction est le
  caractère correspondant à l'opération:

    'a' ... addition
    's' ... soustraction
    'm' ... multiplication standard
    'r' ... multiplication récursive naïve
    'k' ... multiplication Karastuba
*/
extern char read(char *file, number *X, number *Y);


// affiche un nombre A sur la sortie standard suivit du caractère c,
// unité affichée à droite et sans les zéros à gauche
extern void write(number *A, char c);

// génère un nombre aléatoire de n chiffres parmi [0,BASE[
// NB: les chiffres à gauche (de poids forts) peuvent être nuls
extern number *number_random(int n);

#endif
