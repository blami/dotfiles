# This is container for building Ubuntu PPA DPKGs in isolation. I find using
# Docker snappier than pbuilder or sbuilder.
#
# NOTE: This image is meant mostly for interactive use, hence bash entrypoint.
#
# Usage:
# docker build -f /path/to/ppa.dockerfile -t ppa/jammy --build-arg SERIES=jammy .
# docker run -it -v ~/src/ppa:/ppa --name ppa-<package> ppa/jammy
#
# To install build-dependecies *INSIDE* container use:
# mk-build-deps -i /path/to/debian/control

ARG SERIES=latest
FROM ubuntu:${RELEASE}

# Install essential packages
RUN apt-get update \
    && apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        build-essential \
        devscripts \
        debhelper \
        dh-make \
        apt-utils \
        lintian \
        quilt \
        equivs \
        sudo \
    && rm -rf /tmp/* /var/tmp/* \
    && apt-get clean

# Add ppa user with UID:GID 1000:1000 (usually maps to my account and if not it
# can be changed via ARG
ARG UID=1000
ARG GID=1000
RUN addgroup --gid ${GID} ppa \
    && adduser --disabled-password --uid ${UID} --gid ${GID} ppa \
    && addgroup ppa sudo \
    && echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/sudo

# Prepare work volume for mount from host system
VOLUME ["/ppa"]

# Switch to ppa user
USER ppa
WORKDIR /ppa
ENTRYPOINT /bin/bash
