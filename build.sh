#!/bin/bash

VERSION=3.15.0-lite
IMAGE="szaffarano/claws-mail"

if ! [ -z "$http_proxy" ]; then
	BUILD_ARG_HTTP="--build-arg http_proxy=$http_proxy"
fi

if ! [ -z "$https_proxy" ]; then
	BUILD_ARG_HTTPS="--build-arg https_proxy=$https_proxy"
fi

docker build \
    ${BUILD_ARG_HTTP} \
    ${BUILD_ARG_HTTPS} \
    -t ${IMAGE}:${VERSION} \
    .
