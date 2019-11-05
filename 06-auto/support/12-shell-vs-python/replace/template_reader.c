#include <stdio.h>

static const unsigned char message[] = __TEMPLATE__;

int main(void)
{
	size_t i;

	printf("Here is your message: ");
	for (i = 0; i < sizeof(message); i++)
		printf("\\x%02x", message[i]);
	printf("\n");
	return 0;
}
