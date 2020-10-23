RUN=bin/main.exe
TEST=tests

default: build
	dune utop lib

build:
	dune build

run:
	dune build
	dune exec $(RUN)

test:
	dune build
	dune runtest $(TEST)
	
clean:
	dune clean

