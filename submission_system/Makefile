CC=gcc
DEPS=submission.h
CFLAGS=-lcurl

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $<

all: submission.o lib/lcfg.o
	$(CC) -o submit main.c submission.o lib/lcfg.o $(CFLAGS)

clean:
	rm submit submission.o lib/lcfg.o
