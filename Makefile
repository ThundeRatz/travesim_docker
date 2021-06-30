all: build

build: travesim travesim_adapters Dockerfile
	docker build --tag ghcr.io/thunderatz/travesim_pkg:stable .
