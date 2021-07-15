# mailpuller

Back up your IMAP-enabled mail account to a local directory.

## Usage

First, create a local directory for your mail.

```shell
mkdir mail
```

Then run mailpuller in Docker to start downloading your mail.

```shell
docker run \
  --hostname mailpuller \
  -e IMAP_SERVER=imap.gmail.com \
  -e IMAP_PORT=993 \
  -e IMAP_USERNAME=user@gmail.com \
  -e IMAP_PASSWORD=password \
  -v "$PWD"/mail:/mail \
  mailpuller:latest
```

Or, using docker-compose:

```yaml
---
version: "3"
services:
  mailpuller:
    image: mailpuller:latest
    hostname: mailpuller
    environment:
      - IMAP_SERVER=imap.gmail.com
      - IMAP_PORT=993
      - IMAP_USERNAME=user@gmail.com
      - IMAP_PASSWORD=password
    volumes:
      - ./mail:/mail
```

IMPORTANT: The `hostname` is used to check the uniqueness of an email, so it is important that you set it the same every time. This applies to `docker run` or `docker compose`.
