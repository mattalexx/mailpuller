#!/usr/bin/env bash

# Configure
IMAP_SERVER=imap.gmail.com
IMAP_PORT=993
IMAP_USERNAME=user@gmail.com
IMAP_PASSWORD=password
MAILDUMP=./mailtest

set -euo pipefail

cd "$(dirname "${BASE_SOURCE[0]}")"
export IMAP_SERVER IMAP_PORT IMAP_USERNAME IMAP_PASSWORD
docker build -t mailpuller "$(dirname "$0")"
mkdir -p "$MAILDUMP"

# Fire!
docker run \
  -e IMAP_SERVER \
  -e IMAP_PORT \
  -e IMAP_USERNAME \
  -e IMAP_PASSWORD \
  --mount type=bind,src="$(realpath "$MAILDUMP")",target=/mail \
  --rm \
  mailpuller
