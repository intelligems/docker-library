FROM revolutionsystems/python:3.6.6-wee-optimized-lto
MAINTAINER Ioannis Dritsas <dritsas@intelligems.eu>

ENV PYTHONUNBUFFERED=1
ENV DEBIAN_FRONTEND=noninteractive

# Install GDAL dependencies
RUN echo deb http://deb.debian.org/debian testing main contrib non-free >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y libgdal-dev --no-install-recommends && \
    pip install pipenv && \
    pip install gunicorn && \
    apt-get clean -y

# Update C env vars so compiler can find gdal
ENV CPLUS_INCLUDE_PATH=/usr/include/gdal
ENV C_INCLUDE_PATH=/usr/include/gdal

ENV LC_ALL="C.UTF-8"
ENV LC_CTYPE="C.UTF-8"

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Pipfile Pipfile
COPY Pipfile.lock Pipfile.lock

# --ignore-pipfile, using Pipfile.lock file only
# --skip-lock, ignore Pipfile.lock using only Pipfile
# --system builds using system environment and not virtualenv
RUN set -ex && pipenv install --system --skip-lock

COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
ENTRYPOINT ["bash", "entrypoint.sh"]
