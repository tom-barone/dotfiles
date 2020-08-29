
.PHONY: build
build:
	docker build . --tag dotfiles

run: build
	docker run --rm -it -v `pwd`:/home/testuser/dotfiles dotfiles bash

test: build
	docker run --rm -it -v `pwd`:/home/testuser/dotfiles dotfiles ./install.sh && bash --login -ic "./test.sh"
