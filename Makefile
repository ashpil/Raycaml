RUN=bin/main.exe
TEST=tests

default: build
	@dune utop lib

build:
	@dune build
	@echo ""

run:
	@dune build
	@echo ""
	@dune exec $(RUN)

test:
	@dune build
	@dune runtest $(TEST)
	@echo ""
	
clean:
	@dune clean
	-@rm src.zip 2> /dev/null || true
	@echo -e "\033[36mCleaned!\033[0m"

zip:
	@echo -e "\033[31mWARNING:\033[0m Doesn't zip anything not commited to git.\n\033[36msrc.zip made!\033[0m"
	@git archive -o src.zip HEAD
