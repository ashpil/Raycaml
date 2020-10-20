OBJECTS=bin/main.ml
RUN=bin/main.exe
TEST=test

default: build
	dune utop lib

build:
	dune build $(OBJECTS)

run:
	dune build $(OBJECTS)
	dune exec $(RUN)

test:
	dune runtest $(TEST)
	
clean:
	dune clean

