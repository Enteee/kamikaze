# kamikaze 神風 [![Build Status](https://travis-ci.org/Enteee/kamikaze.svg?branch=master)](https://travis-ci.org/Enteee/kamikaze)
_A statically-linked one-shot setuid runner_

Some commands can only run right after container startup. But at this point in time we hopefully already dropped privileges
and switched to a non root user. But what if such a startup task would need root privileges just once? This is where `kamikaze`
steps in. Install `kamikaze` inside your container and give your startup routine that one chance to run a command as root.

## Installation

```sh
$ curl https://raw.githubusercontent.com/Enteee/kamikaze/master/install.sh | sh
```

**Note**: If not run as root, this will use `sudo` to set ownership of `kamikaze` to root

## Usage

```
usage: kamikaze <command> <arguments>
```

## Example

Print effective user id (`id -u`):

```sh
$ kamikaze id -u
0
```

Run `id -u` in a `kamikaze`-container:

```sh
$ docker build -t kamikaze - <<EOF
  FROM alpine
  RUN set -exuo pipefail \
    && apk add curl \
    && curl https://raw.githubusercontent.com/Enteee/kamikaze/master/install.sh | sh

  USER nobody
  CMD ["/kamikaze", "id", "-u"]
EOF
$ docker run kamikaze
0
```

## Build

```sh
$ nix-build
```

**Note**: The built binary can be found under: `result/bin/kamikaze`

## Development Environment

```sh
$ nix-shell
```
