#!/bin/sh
set -ex

export IMAGE_NAME=jojomi/caddy-builder
docker build -t "${IMAGE_NAME}" .

mkdir -p output
docker run --rm \
    -e CADDY_VERSION="${CADDY_VERSION}" \
    -e CADDY_NO_TELEMETRY="${CADDY_NO_TELEMETRY}" \
    -e CADDY_OS="${CADDY_OS}" \
    -e CADDY_ARCH="${CADDY_ARCH}" \
    -v "$(pwd)/output:/output:rw" "${IMAGE_NAME}"