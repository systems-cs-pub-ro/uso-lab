#include <stdio.h>

#ifndef YEAR
 #define YEAR "2013"
#endif

int main(){
  printf("Hello world from " YEAR "\n");
  return 0;
}
