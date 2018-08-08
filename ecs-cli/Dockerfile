FROM sahsu/docker-ecs-cli

COPY entrypoint.sh /
RUN apk add --no-cache --update m4 bash && \
    chmod a+x entrypoint.sh


ENTRYPOINT ["entrypoint.sh"]
