.PHONY: build-docker
build-docker:
	docker build . --tag dotfiles

.PHONY: run-ubuntu
run-ubuntu: build-docker
	docker run --rm -it -v `pwd`:/home/testuser/dotfiles --entrypoint '' dotfiles bash

.PHONY: test-ubuntu
test-ubuntu: build-docker
	docker run --rm -v `pwd`:/home/testuser/dotfiles dotfiles
