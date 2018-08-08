FROM sahsu/docker-ecs-cli

RUN apk add --no-cache --update m4 bash && \
    ln -s /ecs-cli /bin/ecs-cli

ENTRYPOINT ["/bin/bash"]