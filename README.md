# mailpuller

Back up your IMAP-enabled mail account to a local directory.

[![Docker Automated build](https://img.shields.io/docker/cloud/build/mattalxndr/mailpuller?style=for-the-badge)](https://hub.docker.com/r/mattalxndr/mailpuller)

## Usage

First, create a local directory for your mail.

```shell
MAILDUMP=$HOME/backups/mail
mkdir -p $MAILDUMP
```

Then run mailpuller in Docker to start downloading it.

```shell
docker run \
  -e IMAP_SERVER=imap.gmail.com \
  -e IMAP_PORT=993 \
  -e IMAP_USERNAME=user@gmail.com \
  -e IMAP_PASSWORD=$(echo ~/pws/mail) \
  --hostname mailpuller \
  --mount type=bind,src=${MAILDUMP},target=/mail \
  mattalxndr/mailpuller
```

IMPORTANT: The `hostname` is used to check the uniqueness of an email, so it is important that you set it the same every time. This applies to `docker run` or `docker compose`.

## Test

A test script is provided. Add IMAP connection details to the top, and execute:

```shell
vim test.sh
./test.sh
```
