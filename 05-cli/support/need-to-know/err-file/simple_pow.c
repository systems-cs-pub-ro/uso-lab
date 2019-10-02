#include <stdio.h>
#include <math.h>

int main() {
	int N;

	printf("Give me a number N and I will computer 2^N for you: ");
	scanf("%d", &N);
	
	printf("Here is your answer %lf\n", pow(2, N));
	
	return 0;
}
