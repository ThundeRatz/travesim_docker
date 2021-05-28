all: build publish

build: travesim travesim_adapters Dockerfile
	docker build --tag thunderatz/travesim .

publish: build
	docker push thunderatz/travesim
