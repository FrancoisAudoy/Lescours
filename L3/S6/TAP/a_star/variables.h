#ifndef VARIABLES_H
#define VARIABLES_H

// Variables globales pour ne pas s'embêter

#include "OpenGL_SDL.h"
#include <stdbool.h>

typedef struct{
  double x,y;
} point;

typedef struct{
  int x,y;
} position;

typedef struct{
  int X,Y;        // dimensions: X et Y
  int **value;    // valuation des cases: value[i][j], 0<=i<X, 0<=j<Y
  int **mark;     // marquage des cases: mark[i][j], 0<=i<X, 0<=j<Y
  position start; // position de la source
  position end;   // position de la destination
} grid;

// valeurs possibles des cases d'une grille (.value)
enum{
  V_ROOM = 0, // Case vide
  V_WALL,     // Mur
  V_SAND,     // Sable
  V_WATER,    // Eau
  V_MUD,      // Terre
  V_WIND,     // Vent ?
};

// valeurs possibles des marques d'une grille (.mark)
enum{
  M_ZERO = 0x00,
  M_USED = 0x01,
  M_PATH = 0x02,
  M_SEEN = 0x04,
  M_NEXT = 0x08,
};

int width, height;     // dimensions de la fenêtre graphique courante 
bool mouse_left_down;  // bouton gauche de souris enfoncé ?
bool mouse_right_down; // bouton droit de souris enfoncé ?
double scale;          // zoom courrant = nombre de pixels par unité
bool running;          // dans la boucle principale, presser 'q' pour false
int delay;             // délais d'affichage pour drawGrid(), unité = 10 ms

// Objets SDL/GL
SDL_Window *window;
SDL_GLContext glcontext;
GLvoid *gridImage;
GLuint texName;

#endif
