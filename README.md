# Valgrind Docker Image

A simple Docker image with Valgrind and the essential build tools like `gcc`, `make`, and `libc6-dev`.

## Test files

To play around with the examples, you can use the `Makefile` and the stuff in `test_files`. See below.

## Run it

Here's an example.

```
$ docker run -v $HOME:$HOME mooreryan/valgrind --leak-check=full ~/scripts/c/macro_test_linux
```

## Compiling your program first

If you're on a Mac and want to use this, you need to first compile your program so that it will run inside the docker.

### Using gcc

First, use the Docker image to compile the program.

```
$ docker run --workdir $HOME --entrypoint gcc -v $PWD:$HOME mooreryan/valgrind -Wall -g -o test_files/apple test_files/apple.c
```

Then run valgrind on it!

```
$ docker run --workdir $HOME -v $PWD:$HOME mooreryan/valgrind --leak-check=full test_files/apple

==1== Memcheck, a memory error detector
==1== Copyright (C) 2002-2015, and GNU GPL'd, by Julian Seward et al.
==1== Using Valgrind-3.12.0.SVN and LibVEX; rerun with -h for copyright info
==1== Command: test_files/apple
==1==
apple == apple
==1==
==1== HEAP SUMMARY:
==1==     in use at exit: 0 bytes in 0 blocks
==1==   total heap usage: 2 allocs, 2 frees, 4,102 bytes allocated
==1==
==1== All heap blocks were freed -- no leaks are possible
==1==
==1== For counts of detected and suppressed errors, rerun with: -v
==1== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
```

That's it!

### Using a Makefile.

If you have a project and you want to be a little fancy, try using `make`.

Here is an example Makefile

```bash
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
```

Now to test the `apple` program with Valgrind, just type

```
$ make apple_valgrind
```

That's it!

## License

<a rel="license"
     href="http://creativecommons.org/publicdomain/zero/1.0/">
<img src="http://i.creativecommons.org/p/zero/1.0/88x31.png" style="border-style: none;" alt="CC0" />
</a>

To the extent possible under law, Ryan M. Moore has waived all copyright and related or neighboring rights to this project.

_If for whatever reason, CC0 will not work for your project, you may use MIT or the Unlicense._
