FROM python:2.7-alpine

ARG VERSION=5.15
ARG UID=1000
ARG GID=1000

RUN mkdir -p /home/getmail/.getmail /mail
ADD ./getmailrc.template /home/getmail/.getmail/
ADD ./init.sh /home/getmail/

RUN set -x \
  && apk add --update libintl gettext \
  && mv /usr/bin/envsubst /usr/local/bin/envsubst \
  && wget http://pyropus.ca/software/getmail/old-versions/getmail-$VERSION.tar.gz -O - | \
    tar -xz --strip-components=1 && python setup.py install \
  && addgroup -g ${GID} getmail && adduser -u ${UID} -G getmail -D -g '' getmail \
  && chown -R getmail: /home/getmail /mail \
  && apk del openssl tzdata gettext libintl \
  && rm -rf /var/cache/apk/* \
  && rm -rf /tmp/*

VOLUME /home/getmail.getmail
VOLUME /mail

WORKDIR /home/getmail
USER getmail

CMD [ "sh", "-c", "./init.sh && getmail" ]
