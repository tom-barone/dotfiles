.PHONY: build
build:
	docker build . --tag dotfiles

.PHONY: run
run: build
	docker run --rm -it -v `pwd`:/home/testuser/dotfiles dotfiles bash

.PHONY: test
test: build
	docker run --rm -it -v `pwd`:/home/testuser/dotfiles dotfiles ./install.sh || true && bash --login -ic "./test.sh"
