all: build

include .env
export

build:
	docker build --build-arg ALPINE_VERSION=$(ALPINE_VERSION)  --no-cache=true -t mheers/cloud-native-tools:$(ALPINE_VERSION) .

push:
	docker tag mheers/cloud-native-tools:$(ALPINE_VERSION) mheers/cloud-native-tools:latest
	docker push mheers/cloud-native-tools:$(ALPINE_VERSION)
	docker push mheers/cloud-native-tools:latest
