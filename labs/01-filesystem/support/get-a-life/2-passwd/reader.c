#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
	FILE *fptr;
	char c;

	if (argc != 2) {
		printf("Invalid number of arguments: ./reader path_to_file\n");
		exit(0);
	}

	if (strcmp("/etc/passwd", argv[1]) == 0) {
		printf("/etc/passwd is not allowed\n");
		exit(0);
	}

	fptr = fopen(argv[1], "r");
	if (fptr == NULL) {
        printf("Cannot open file \n");
        exit(0);
    }

    c = fgetc(fptr);
    while (c != EOF) {
    	printf("%c", c);
    	c = fgetc(fptr);
    }

    fclose(fptr);
	return 0;
}
