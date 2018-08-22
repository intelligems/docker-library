FROM bashell/alpine-bash

COPY read.sh /bin/read.sh
COPY entrypoint.sh .

RUN chmod a+x read.sh && \
    chmod a+x entrypoint.sh

ENTRYPOINT [ "entrypoint.sh" ]

