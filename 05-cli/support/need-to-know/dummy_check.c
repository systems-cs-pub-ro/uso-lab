#include <stdio.h>
#include <string.h>
#include <ctype.h>

int check_email(char *email) {
	int length, i;

	length = strlen(email);

	for (i = 0; i < length; i++) {
		if (email[i] == '@') {
			return 0;
		}
	}

	return 1;
}

int check_name(char *name) {
	unsigned char c;

	while ( ( c = *name ) && isalpha( c )) {
		name++;
	}

	return !(*name == '\0'); 
}

int check_age(int age) {
	return (age < 0) ? 1 : 0;
}

int main(int argc, char **argv) {
	char email[100];
	char name[100];
	char surname[100];
	int age;

	printf("Enter your name. Make sure it only contains letters: ");
	scanf("%s", name);

	printf("Now enter your surname. Make sure it only contains letters: ");
	scanf("%s", surname);

	printf("Can I have your email? ");
	scanf("%s", email);

	printf("And last, give me your age: ");
	scanf("%d", &age);

	int err_name = check_name(name);
	int err_surname = check_name(surname);
	int err_email = check_email(email);
	int err_age = check_age(age);

	if (!err_name && !err_surname && !err_email && !err_age) {
		printf("[log] Thanks! You're good to go..\n");
		return 0;
	}

	if (err_name) {
		fprintf(stderr, "[error] The name you gave me isn't correct.\n");
	}

	if (err_surname) {
		fprintf(stderr, "[error] The surname you gave me isn't correct.\n");
	}

	if (err_email) {
		fprintf(stderr, "[error] That's not a valid email, sir.\n");
	}

	if (err_age) {
		fprintf(stderr, "[error] Sorry, but you can't have a negative age.\n");
	}
	
	return 0;
}
