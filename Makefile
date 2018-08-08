CFLAGS = -Wall -g

THIS_DIR = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

SRC = test_files
BIN = $(SRC)/bin

.PHONY: clean apple_valgrind

apple:
	$(CC) $(CFLAGS) -o $(BIN)/$@ $(SRC)/$@.c

apple_docker:
	docker run --workdir $(HOME) --entrypoint $(CC) -v $(THIS_DIR):$(HOME) mooreryan/valgrind $(CFLAGS) -o $(BIN)/$@ $(SRC)/apple.c

apple_valgrind: apple_docker
	docker run --workdir $(HOME) -v $(THIS_DIR):$(HOME) mooreryan/valgrind $(BIN)/$^

clean:
	rm -r $(BIN)/*
