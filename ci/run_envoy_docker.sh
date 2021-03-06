#!/bin/bash

set -e

[[ -z "${IMAGE_ID}" ]] && IMAGE_ID="latest"
[[ -z "${ENVOY_API_DOCKER_BUILD_DIR}" ]] && ENVOY_API_DOCKER_BUILD_DIR=/tmp/envoy-api-docker-build

mkdir -p "${ENVOY_API_DOCKER_BUILD_DIR}"
docker pull lyft/envoy-build:"${IMAGE_ID}"
docker run -t -i -u $(id -u):$(id -g) -v "${ENVOY_API_DOCKER_BUILD_DIR}":/build \
  -v "$PWD":/source lyft/envoy-build:"${IMAGE_ID}" /bin/bash -c "cd source && $*"
