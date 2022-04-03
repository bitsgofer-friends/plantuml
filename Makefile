DOCKER ?= docker
CURL ?= curl

VERSION := 1.2022.3

image_registry      := registry.hub.docker.com
image_name          := bitsgofer/plantuml
image_tag           := ${VERSION}
versioned_full_img  := ${image_registry}/${image_name}:${image_tag}
latest_full_img     := ${image_registry}/${image_name}:latest
versioned_short_img := ${image_name}:${image_tag}
latest_short_img    := ${image_name}:latest

all:
.PHONY: all

clean:
	rm -rf image/vendor
.PHONY: clean

image/vendor:
	mkdir -p image/vendor

image/vendor/plantuml.jar: image/vendor
	$(CURL) -sL -o image/vendor/plantuml.jar "http://sourceforge.net/projects/plantuml/files/plantuml.${VERSION}.jar/download"

image: image/vendor/plantuml.jar image/Dockerfile
	$(DOCKER) build \
		-t ${versioned_full_img} \
		-f image/Dockerfile \
		./image
	$(DOCKER) tag ${versioned_full_img} ${latest_full_img}
	$(DOCKER) tag ${versioned_full_img} ${versioned_short_img}
	$(DOCKER) tag ${versioned_full_img} ${latest_short_img}
.PHONY: image

push:
	$(DOCKER) push ${versioned_full_img}
	$(DOCKER) push ${latest_full_img}
	$(DOCKER) push ${versioned_short_img}
	$(DOCKER) push ${latest_short_img}
.PHONY: push

test: cmd := docker run --rm -i ${versioned_short_img} < tests/example.uml
test:
	@echo "Check render command works:"
	@echo "${cmd}"
	@echo "----------------------------------------"
	@echo ""
	@${cmd}
.PHONY:
