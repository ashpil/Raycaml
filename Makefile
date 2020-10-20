RUN=bin/main.exe
TEST=test

default: build
	dune utop lib

build:
	dune build

run:
	dune build
	dune exec $(RUN)

test:
	dune runtest $(TEST)
	
clean:
	dune clean

