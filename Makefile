# Makefile for docker-build-args project

# Run the server locally
run:
	node server.js

# Run the server locally with a custom DOCKER_TAG
tag-run:
	DOCKER_TAG=fubar node server.js

# Build the docker container with a custom tag
# Usage: make build TAG=testver
build:
	docker build . --build-arg DOCKER_TAG='$(TAG)' -t my-build-args

# Build the docker container using the DOCKER_TAG environment variable
build-env:
	export DOCKER_TAG=$(TAG) && docker build . --build-arg DOCKER_TAG="$$DOCKER_TAG" -t my-build-args

# Run the docker container
run-docker:
	docker run -p 3000:3000 --name test-build-args ghcr.io/mitchallen/docker-build-args

# Define the publish target
.PHONY: publish
publish:
	@echo "Switching to main branch..."
	git checkout main
	@echo "Incrementing version..."
	-@npm version patch || (\
	  echo "Tag already exists. Deleting local and remote tag, then retrying..." && \
	  export TAG=$$(node -p "require('./package.json').version") && \
	  git tag -d v$$TAG && \
	  git push --delete origin v$$TAG && \
	  npm version patch \
	)
	@echo "Pushing changes and tags..."
	git push && git push --tags

# Show help if no target is given
help:
	@echo "Available targets:"
	@echo "  run         - Run the server locally"
	@echo "  tag-run     - Run the server locally with a custom DOCKER_TAG (fubar)"
	@echo "  build       - Build the docker container with a custom tag (make build TAG=yourtag)"
	@echo "  build-env   - Build the docker container using the DOCKER_TAG environment variable (make build-env TAG=yourtag)"
	@echo "  run-docker  - Run the docker container"
	@echo "  publish     - Switch to main, bump version, push changes and tags"
	@echo "  help        - Show this help message"

.DEFAULT_GOAL := help
