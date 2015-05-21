.PHONY: test consul

test:
	docker run --rm -it -v $$(pwd):/home ruby:2.2 /bin/bash

consul:
	docker rm consul
	docker run -d --publish 8500:8500 --publish 53:53 --publish 53:53/udp --name consul progrium/consul -server -bootstrap -ui-dir /ui
