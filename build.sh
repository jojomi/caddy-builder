#!/bin/sh
set -ex

export VERSION=${CADDY_VERSION:-v0.11.5}

go get -u github.com/mholt/caddy
go get -u github.com/caddyserver/builds
cd /go/src/github.com/mholt/caddy/caddy
git checkout ${VERSION}

# It is possible to disable telemetry in this build.
# If it would have been a simple CLI switch, it would be a lot easier,
# but it seems I have to disable all metrics one by one.
# Caddy is a server and should behave as such, not as a client for whatever
# data collection (my opinion).
if [ "${CADDY_NO_TELEMETRY}" = "true" ]; then
    git config --global user.email "patcher@caddy.server"
    git config --global user.name "Patcher"
    git am /patches/disable-telemetry.patch
fi

# Adding plugins:
# https://github.com/mholt/caddy/wiki/Plugging-in-Plugins-Yourself

mkdir -p /output
CGO_ENABLED=0 go run build.go -goos="${CADDY_OS:-linux}" -goarch="${CADDY_ARCH:-amd64}"
mv caddy caddy.exe /output/ 2>/dev/null