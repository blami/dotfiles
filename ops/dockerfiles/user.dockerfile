# This is generic Ubuntu container for interactive use with local volume. I use
# this when I need special environment to e.g. compile something I have in
# local workspace

# Usage:
# docker build -f /path/to/user.dockerfile -t user .
# docker run -it -v ~/path/to/any/dir:/user -name user-<whatever> user

FROM ubuntu:latest

RUN apt-get update \
    && apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        sudo \
    && rm -rf /tmp/* /var/tmp/* \
    && apt-get clean

ARG UID=1000
ARG GID=1000
RUN addgroup --gid ${GID} user \
    && adduser --disabled-password --uid ${UID} --gid ${GID} user \
    && addgroup user sudo \
    && echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/sudo

VOLUME ["/user"]

USER user
WORKDIR /user
ENTRYPOINT /bin/bash
