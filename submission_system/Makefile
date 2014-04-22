CC=gcc
DEPS=submission.h
CFLAGS=-lcurl

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $<

all: submission.o lib/lcfg.o config.o
	$(CC) -o submit main.c submission.o lib/lcfg.o config.o $(CFLAGS)

clean:
	rm submit *.o lib/lcfg.o
