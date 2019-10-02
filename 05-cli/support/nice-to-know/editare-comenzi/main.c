#include <stdio.h>
#include "my_math.h"

int main() {
	int a, b;
	printf("Give me the first number: ");
	scanf("%d", &a);
	printf("Give me the second number: ");
	scanf("%d", &b);

	printf("Here is your sum: %d\n", sum(a, b));

	return 0;
}
