FROM python:2.7-alpine

ARG VERSION=5.15
ARG UID=1000
ARG GID=1000

RUN cd /tmp \
  && wget http://pyropus.ca/software/getmail/old-versions/getmail-$VERSION.tar.gz -O- \
    | tar -xz --strip-components=1 \
  && python setup.py install \
  && addgroup -g ${GID} usr && adduser -u ${UID} -G usr -DHg '' usr \
  && mkdir /mail /mail/cur /mail/new /mail/tmp \
  && chown -R usr: /mail

ADD getmail.sh /usr/local/bin

VOLUME /mail

USER usr

ENTRYPOINT [ "getmail.sh" ]
CMD [ "--getmaildir", "/mail/.getmail" ]
