.PHONY: default build auto-build-and-push


PLATFORMS ?= linux/amd64,linux/arm64
DOCKER_IMAGE ?= raquette/kibana-oss
VERSION ?= "edge"
KIBANA_VERSION ?= "7.9.3"

MANIFEST_TAG = $(DOCKER_IMAGE):$(VERSION)

default: build

auto-build-and-push:
	docker buildx build  --push --platform $(PLATFORMS) -t "$(MANIFEST_TAG)"  --build-arg KIBANA_VERSION=${KIBANA_VERSION} -f Dockerfile . 

build:
	docker buildx build --platform $(PLATFORMS) -t "$(MANIFEST_TAG)"  --build-arg KIBANA_VERSION=${KIBANA_VERSION} -f Dockerfile . 
