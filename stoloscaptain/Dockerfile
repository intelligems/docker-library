FROM python:3.6-slim

RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    wget \
    gnupg2 \
    software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable" && \
    apt-get update && apt-get install -y docker-ce && \
    curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    wget https://cf979153cd14525475d4-f860d1dda29fa1b9bcbf643d12472ae9.ssl.cf1.rackcdn.com/unison/unison-2.48.3-4.02 -O /usr/local/bin/unison && \
    chmod +x /usr/local/bin/unison && \
    pip install stolosctl[compose]==0.4.5

WORKDIR /usr/src/app/
