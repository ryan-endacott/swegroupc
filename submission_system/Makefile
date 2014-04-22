CC=gcc
DEPS=submission.h
CFLAGS=-lcurl

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $<

all: submission.o
	$(CC) -o submit main.c submission.o $(CFLAGS)

clean:
	rm submit submission.o
