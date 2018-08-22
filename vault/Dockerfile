FROM bashell/alpine-bash

COPY read.sh /root/read.sh
COPY entrypoint.sh /root/entrypoint.sh

RUN chmod a+x read.sh && \
    chmod a+x entrypoint.sh

ENTRYPOINT [ "entrypoint.sh" ]

