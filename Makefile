.PHONY: build
build-docker:
	docker build . --tag dotfiles

.PHONY: run
run-docker: build
	docker run --rm -it -v `pwd`:/home/testuser/dotfiles dotfiles bash

.PHONY: test
test: build
	docker run --rm -it -v `pwd`:/home/testuser/dotfiles dotfiles bash -c "./install.sh || true && bash --login -ic './test.sh'"
