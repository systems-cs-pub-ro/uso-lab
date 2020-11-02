all: hangman

hangman: hangman.o
	gcc -o hangman hangman.o


hangman.o: hangman.c
	gcc -c hangman.c

clean:
	rm -rf *.o hangman

