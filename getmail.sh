#!/usr/bin/env sh

set -eu

# Set up /mail
(cd /mail && mkdir -p cur new tmp .getmail)
if [ ! -f /mail/.getmail/getmailrc ]; then
  printf 'Config not found at /mail/.getmail/getmailrc. Creating from from environment variables\n'

  : "${IMAP_SERVER?Required}"
  : "${IMAP_PORT?Required}"
  : "${IMAP_USERNAME?Required}"
  : "${IMAP_PASSWORD?Required}"

  cat <<EOF >/mail/.getmail/getmailrc
[retriever]
type      = SimpleIMAPSSLRetriever
server    = ${IMAP_SERVER}
port      = ${IMAP_PORT}
username  = ${IMAP_USERNAME}
password  = ${IMAP_PASSWORD}
mailboxes = ALL

[destination]
type = Maildir
path = /mail/

[options]
verbose = 1
read_all = False
delivered_to = false
received = false
delete = false
EOF
fi

# Execute getmail
exec getmail "$@"
