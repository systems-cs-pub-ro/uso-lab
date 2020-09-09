all: program

program: main.o a.o b.o
	gcc main.o a.o b.o -o program

main.o: main.c a.o
        gcc -c main.c

a.o: a.c b.o
        gcc -c a.c

b.o: b.c main.o
        gcc -c b.c

run: program
	./program

clean:
	rm *.o program