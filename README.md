# kamikaze 神風 [![Build Status](https://travis-ci.org/Enteee/kamikaze.svg?branch=master)](https://travis-ci.org/Enteee/kamikaze)
_A statically-linked one-shot setuid runner_

Some commands can only run right after container startup. But at this point in time we hopefully already dropped privileges
and switched to a non root user. But what if such a startup task would need root privileges just once? This is where `kamikaze`
steps in. Install `kamikaze` inside your container and give your startup routine that one chance to run a command as root.

## Installation

```
$ curl https://path/to/install.sh | sh
```

## Examples

## Commands

* Build: `nix-build`
* Development Environment: `nix-shell`
