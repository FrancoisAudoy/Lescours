#include <stdlib.h>
#include "heap.h"

heap heap_create(int n, int (*f)(const void *, const void *)){
  heap tas = (heap)malloc(sizeof(*tas));
  if(tas == NULL){
    return NULL;
  }
  tas->array = malloc(sizeof(void*)*n);
  tas->nmax = n;
  tas->size = 0;
  tas->f = f;
  return tas;
}

void heap_destroy(heap h){
  free(h->array);
  free(h);
}


int heap_empty(heap h){
  if(h->size == 0)
    return 1;
  else
    return 0;
}

int heap_add(heap h, void *object){
  if(h->size == h->nmax )
    return 1;
  else{
    h->size++;
    h->array[h->size] = object;
    int pos_obj = h->size;
    while( pos_obj != 1 && h->f(h->array[pos_obj/2], object) > 0 ){
      void *tmp= h->array[pos_obj/2];
      h->array[pos_obj/2] = object;
      h->array[pos_obj]=tmp;
      pos_obj=pos_obj/2;
    }
    return 0;
  }
}


void *heap_top(heap h){
  if(heap_empty(h) != 0)
    return h->array[1];
  return NULL;
}

//Recuperer le fils le plus petit au lieu de comparer la racine à l'un puis l'autre
void *heap_pop(heap h){
  if(heap_empty(h)!=0)
    return NULL;
  else{
    void *root = h->array[1];
    h->array[1] = h->array[h->size];
    h->size--;
    int pos_obj =1;
    int min;
    while(1){
      if(pos_obj*2 <= h->size || pos_obj*2 +1 <= h->size){
	if (h->f(h->array[pos_obj*2],h->array[(pos_obj*2)+1]) > 0)
	  min = pos_obj*2+1;
	else
	  min = pos_obj*2;
	if( min<= h->size && (h->f(h->array[pos_obj],h->array[min]) > 0)){
	  void *tmp = h->array[pos_obj];
	  h->array[pos_obj] = h->array[min];
	  h->array[min]= tmp;
	  pos_obj = min;
	}
	else
	  return root;
      }
      else
	return root;
    }
  }
}

