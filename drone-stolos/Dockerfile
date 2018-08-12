FROM python:3.6-slim

RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    wget \
    gnupg2 \
    software-properties-common && \
    wget https://cf979153cd14525475d4-f860d1dda29fa1b9bcbf643d12472ae9.ssl.cf1.rackcdn.com/unison/unison-2.48.3-4.02 -O /usr/local/bin/unison && \
    chmod +x /usr/local/bin/unison && \
    pip install stolosctl[compose]==0.4.5

COPY drone-stolos.sh /bin/
RUN chmod a+x /bin/drone-stolos.sh

ENTRYPOINT /bin/drone-stolos.sh


