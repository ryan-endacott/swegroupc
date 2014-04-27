CC=gcc
DEPS=submission.h
CFLAGS=-lcurl -lm

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $<

all: submission.o lib/lcfg.o config.o fileInfo.o logging.o lib/cJSON.o
	$(CC) -o submit main.c submission.o lib/lcfg.o config.o fileInfo.o logging.o lib/cJSON.o $(CFLAGS)

clean:
	rm submit *.o lib/lcfg.o
