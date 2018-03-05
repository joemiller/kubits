#!/bin/bash
set -e

cleanup() {
  docker rm src >/dev/null
}
trap cleanup EXIT

# create dummy container, copy the project into its /src volume to be re-used by other docker tasks
docker create -v /src --name src alpine:3.7 /bin/true
docker cp . src:/src

# rpm
pkg_type="rpm"
container=$(docker run \
  -d \
  --rm \
  --volumes-from src \
  -w /src \
  alanfranz/fpm-within-docker:fedora-rawhide \
  sleep infinity)
docker exec -i -e "PKG_TYPE=${pkg_type}" "$container" /src/scripts/package-inner.sh
docker cp "${container}":/src/pkg/. ./pkg
docker stop -t0 "$container" >/dev/null # stop here will remove container

# deb
pkg_type="deb"
container=$(docker run \
  -d \
  --rm \
  --volumes-from src \
  -w /src \
  alanfranz/fpm-within-docker:debian-stretch \
  sleep infinity)
# the debian fpm container lacks git, install it
docker exec "$container" /bin/sh -c 'apt-get -qy update; apt-get install -qy git'
docker exec -i -e "PKG_TYPE=${pkg_type}" "$container" /src/scripts/package-inner.sh
docker cp "${container}":/src/pkg/. ./pkg
docker stop -t0 "$container" >/dev/null # stop here will remove container
