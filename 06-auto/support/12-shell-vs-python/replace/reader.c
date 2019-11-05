#include <stdio.h>

static const unsigned char message[] = { 32, 45, 32, 32, 49, 36, 44, 36, 49, 36, };

int main(void)
{
	size_t i;

	printf("Here is your message: ");
	for (i = 0; i < sizeof(message); i++)
		printf("\\x%02x", message[i]);
	printf("\n");
	return 0;
}
