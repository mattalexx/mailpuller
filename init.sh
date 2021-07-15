#!/usr/bin/env sh

set -eu

# Set up /mail
if [ "$(stat -c %U /mail)" = root ]; then
  printf >&2 'ERROR: /mail cannot be owned by root. '
  printf >&2 'Try creating the local map directory before starting container.\n...'
  exit 1
fi
(cd /mail && mkdir -p cur new tmp)

# Set up /home/getmail/.getmail/getmailrc
if [ ! -f .getmail/getmailrc ]; then
  printf 'Config not found: /home/getmail/.getmail/getmailrc. Creating from from environment variables'

  : "${IMAP_SERVER?Required}"
  : "${IMAP_PORT?Required}"
  : "${IMAP_USERNAME?Required}"
  : "${IMAP_PASSWORD?Required}"

  envsubst > .getmail/getmailrc < .getmail/getmailrc.template
fi
