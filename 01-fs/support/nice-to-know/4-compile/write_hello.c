#include <stdio.h>
#include <util/debug.h>

int main(void)
{
	FILE *f;

	f = fopen("hello.out", "wt");
	DIE(f == NULL, "fopen");

	fputs("Hello, World!\n", f);

	return 0;
}
