FROM alpine:3.7

ENV PACKAGES "postgresql-client bash"

RUN apk add --update --no-cache $PACKAGES

COPY psql-entry.sh /root
RUN chmod a+x /root/psql-entry.sh

ENTRYPOINT [ "/root/psql-entry.sh" ]