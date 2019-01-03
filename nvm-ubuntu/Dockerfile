FROM theseg/docker-ubuntu-nvm:latest

COPY .bashrc /root/.bashrc
RUN mkdir -p /usr/src/project/

WORKDIR /usr/src/project
ENTRYPOINT ["/bin/bash"]