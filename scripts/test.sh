#!/bin/bash

cleanup() {
  docker rm src >/dev/null
}
trap cleanup EXIT

# create dummy container, copy the project into its /src volume to be re-used by other docker tasks
docker create -v /src --name src alpine:3.7 /bin/true
docker cp . src:/src
docker run --rm -i --volumes-from src -w /src koalaman/shellcheck-alpine shellcheck "$@"
