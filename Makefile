.PHONY: build-docker
build-docker:
	docker build . --tag dotfiles

.PHONY: run-docker
run-ubuntu: build-docker
	docker run --rm -it -v `pwd`:/home/testuser/dotfiles dotfiles bash

.PHONY: test-ubuntu
test-ubuntu: build-docker
	docker run --rm -it -v `pwd`:/home/testuser/dotfiles dotfiles bash -c "./install.sh || true && bash --login -ic './test.sh'"
