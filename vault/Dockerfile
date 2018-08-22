FROM bashell/alpine-bash

COPY read.sh /bin/read.sh
COPY entrypoint.sh .

RUN chmod a+x /bin/read.sh && \
    chmod a+x entrypoint.sh

ENTRYPOINT [ "/root/entrypoint.sh" ]

# Keep container open
CMD [ "tail -f /dev/null" ]

