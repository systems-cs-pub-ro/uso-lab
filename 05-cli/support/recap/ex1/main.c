#include <stdio.h>

int main() {
	char name[256];
	printf("Hey there, what's your name? ");
	gets(name);
	printf("Hello, %s!\n", name);
	return 0;
}
