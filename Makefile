.PHONY: clean check install

PREFIX ?= "/usr/local"

all: pomd4c

pomd4c: pomd4c.c
	$(CC) $(CFLAGS) ./pomd4c.c -o ./pomd4c

check: API.md
	./pomd4c ./pomd4c.c > ./API.md

install: pomd4c
	cp -v ./pomd4c $(PREFIX)/bin/pomd4c

clean:
	rm -f ./pomd4c
