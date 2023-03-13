
## Usage

```sh
docker run -p 3000:3000 --name test-build-args ghcr.io/mitchallen/docker-build-args
```

* Browse to: http://localhost:3000/
* Version should match docker version

### Run locally

```sh
node server.js
```

Test docker tag (will appear in version for / response)

```sh
DOCKER_TAG=fubar node server.js
```

### Trigger a build

Trigger a build
Be sure to increment the tag each time.

```sh
git checkout main
git tag v1.0.0
git push origin --tags
```

### Build docker container

```sh
docker build . --build-arg DOCKER_TAG='testver' -t my-build-args

export DOCKER_TAG=4.5.6
docker build . --build-arg DOCKER_TAG="$DOCKER_TAG" -t my-build-args
```

### Create a run the container

```sh
docker run -p 3000:3000 --name test-build-args my-build-args
```

### Cleanup

```sh
docker stop test-build-args
docker rm test-build-args
docker rmi my-build-args
```

## Single line commands

### Create

```sh
docker build . -t my-build-args && docker run -p 3000:3000 --name test-build-args my-build-args
```

### Remove

```sh
docker stop test-build-args && docker rm test-build-args && docker rmi my-build-args
```