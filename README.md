# caddy-builder

## How to make your own Caddy binary from source

1. **Clone this repository**: `git clone https://github.com/jojomi/caddy-builder.git && cd caddy-builder`
2. **Define your requirements** (see list of options below)
3. **Compile Caddy** by executing `./run.sh`
4. **Obtain your binary** in `output` folder

## Options

Environment variables supported:

| Variable Name  | Explanation |
| ------------- | ------------- |
| CADDY_VERSION  | must match a [tag in Caddy repo](https://github.com/mholt/caddy/tags) |
| CADDY_NO_TELEMETRY  | set to `true` to disable telemetry collection |
| CADDY_OS  | GOOS value, default `linux` |
| CADDY_ARCH  | GOARCH value, default `amd64` |

## Examples

* **Make a 64-Bit Linux binary**: `CADDY_VERSION=v0.11.5 ./run.sh`

* **Make a 64-Bit Windows binary** (on a Linux host): `CADDY_VERSION=v0.11.5 CADDY_OS=windows ./run.sh`

* **Make a MacOS X binary** without telemetry and for a slightly older version (on a Linux host): `CADDY_VERSION=v0.11.3 CADDY_NO_TELEMETRY=true CADDY_OS=darwin ./run.sh`


 
## Notices

* This builder allows to patch Caddy to remove the **telemetry** data collection, see `CADDY_NO_TELEMETRY` option. The patch supplied works on v0.11.5 YMMV on different Caddy versions.
* Adding **plugins** is not yet supported. A pull request adding this would be very welcome! `build.sh` contains a hint about what to do.
* You should always set `CADDY_VERSION` manually to avoid building an out-of-date possibly insecure webserver. PR welcome for doing some git magic inside `build.sh` to select most recent release tag.