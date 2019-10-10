#include <stdio.h>
#include <stdlib.h>

#include "a.h"
#include "b.h"

int main() {
    printf("globalVar = %d\n", globalVar);
    print1();

    double value = print2(0.5);
    printf("value = %f\n", value);
    
    return 0;
}
