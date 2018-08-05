FROM alpine:3.7

ENV PACKAGES "postgresql-client bash"

RUN apk add --update --no-cache $PACKAGES

COPY psql-entry.sh .
RUN chmod a+x psql-entry.sh

ENTRYPOINT [ "psql-entry.sh" ]