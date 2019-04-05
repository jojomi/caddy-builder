#!/bin/sh
set -ex

export IMAGE_NAME=jojomi/caddy-builder
docker build -t "${IMAGE_NAME}" .

mkdir -p output
rm -f output/*
docker run --rm -v "$(pwd)/output:/output:rw" "${IMAGE_NAME}"