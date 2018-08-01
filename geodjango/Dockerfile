FROM python:3.6-slim
MAINTAINER Ioannis Dritsas <dritsas@intelligems.eu>

ENV PYTHONUNBUFFERED=1

# Add unstable repo to allow us to access latest GDAL builds
# Existing binutils causes a dependency conflict, correct version will be installed when GDAL gets intalled
RUN echo deb http://deb.debian.org/debian testing main contrib non-free >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get remove -y binutils && \
    apt-get autoremove -y

# Install GDAL dependencies
RUN apt-get install -y libgdal-dev g++ --no-install-recommends && \
    pip install pipenv && \
    pip install whitenoise && \
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
RUN set -ex && pipenv install --system

COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
ENTRYPOINT ["bash", "entrypoint.sh"]
