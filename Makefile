.PHONY: test

test:
	docker run --rm -it -v $$(pwd):/home ruby:2.2 /bin/bash
