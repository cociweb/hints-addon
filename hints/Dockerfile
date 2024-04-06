ARG BUILD_FROM
FROM ${BUILD_FROM}



# Install Whisper
WORKDIR /usr/src
ARG HINTS_VERSION

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
        build-essential \
        netcat-traditional \
        swig \
        git \
        python3 \
        python3-dev \
        python3-pip \
        python3-venv

RUN python3 -m venv myenv \
    && . ./myenv/bin/activate

RUN rm /usr/lib/python3.11/EXTERNALLY-MANAGED

RUN pip3 install --no-cache-dir -U  --upgrade pip
RUN pip3 install --no-cache-dir -U \
        setuptools \
        wheel

WORKDIR /
ADD https://github.com/cociweb/hints/archive/refs/tags/v${HINTS_VERSION}.tar.gz hints-${HINTS_VERSION}.tar.gz
RUN ls -lah
RUN pip3 install --no-cache-dir hints-${HINTS_VERSION}.tar.gz


WORKDIR /usr/src
RUN apt-get purge -y --auto-remove \
        build-essential \
        python3-dev
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /
COPY rootfs /

LABEL org.opencontainers.image.source https://github.com/cociweb/hints-addon


# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=30s \
        CMD echo '{ "type": "describe" }' \
        | nc -w 1 localhost 10300 \
        | grep -q "hints" \
        || exit 1
