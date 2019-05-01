#!/usr/bin/env sh
set -euo pipefail
REPO="Enteee/kamikaze"
INSTALL="install -m 4755 -o root kamikaze-download kamikaze"

curl -s "https://api.github.com/repos/${REPO}/releases/latest" \
   | grep "browser_download_url" \
   | cut -d '"' -f 4 \
   | xargs -n1 curl -s -L --output kamikaze-download

trap 'rm kamikaze-download' EXIT

if [[ $EUID -ne 0 ]]; then
  sudo $INSTALL
else
  $INSTALL
fi
