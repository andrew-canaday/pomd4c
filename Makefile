.PHONY: clean check

all: pomd4c

pomd4c: pomd4c.c
	$(CC) ./pomd4c.c -o ./pomd4c

check: API.md
	./pomd4c ./pomd4c.c > ./API.md

clean:
	rm -f ./pomd4c
