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

## Release Naming

> Kyōiku kanji (教育漢字, literally "education kanji"), also known as Gakunenbetsu kanji haitōhyō (学年別漢字配当表, literally "list of kanji by school year") is a list of 1,006 kanji and associated readings developed and maintained by the Japanese Ministry of Education that prescribes which kanji, and which readings of kanji, Japanese schoolchildren should learn for each year of primary school. Although the list is designed for Japanese children, it can also be used as a sequence of learning characters by non-native speakers as a means of focusing on the most commonly used kanji. (ja:学年別漢字配当表)
>
> -- <cite>[from Wikipedia: Kyōiku kanji](https://en.wikipedia.org/wiki/Ky%C5%8Diku_kanji)</cite>
