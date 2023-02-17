all: build

include .env
export

build: docker

docker: ##  Builds the application for amd64 and arm64
	docker buildx build --build-arg ALPINE_VERSION=$(ALPINE_VERSION) --platform linux/amd64,linux/arm64 -t mheers/cloud-native-tools:$(ALPINE_VERSION) -t mheers/cloud-native-tools:latest --push .

## TODO: add --no-cache=true
