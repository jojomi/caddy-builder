#!/bin/sh
set -ex

export CADDY_VERSION=0.11.5

go get -u github.com/mholt/caddy
go get -u github.com/caddyserver/builds
cd /go/src/github.com/mholt/caddy/caddy
git checkout v${CADDY_VERSION}

# I decided to disable telemetry completely in this build.
# If it would have been a simple CLI switch, I would have just put the switch to the CMD,
# but it seems I have to disable all metrics one by one. Caddy is a server and should behave
# as such, not as a client for whatever data collection (my opinion).
# Disable next line if you want to contribute to telemetry data collection.
#sed -i"" 's/var EnableTelemetry = true/var EnableTelemetry = false/g' /go/src/github.com/mholt/caddy/caddy/caddymain/run.go
git config --global user.email "patcher@caddy.server"
git config --global user.name "Patcher"
git am /patches/disable-telemetry.patch


# Adding plugins:
# https://github.com/mholt/caddy/wiki/Plugging-in-Plugins-Yourself

mkdir -p /output
CGO_ENABLED=0 go run build.go -goos=linux -goarch=amd64
mv caddy /output/