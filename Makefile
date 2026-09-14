IMAGE_NAME ?= project-devops-deploy
IMAGE_TAG  ?= latest
REGISTRY   ?= ghcr.io/i-evgenii

docker-build:
	docker build -t $(REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG) .

docker-run:
	docker run --rm -p 8080:8080 $(REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG)

docker-push:
	docker push $(REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG)

test:
	./gradlew test

start: run

run:
	./gradlew bootRun

update-gradle:
	./gradlew wrapper --gradle-version 9.2.1

update-deps:
	./gradlew versionCatalogUpdate

install:
	./gradlew dependencies

build:
	./gradlew build

lint:
	./gradlew spotlessCheck

lint-fix:
	./gradlew spotlessApply

.PHONY: build docker-build docker-run docker-push
