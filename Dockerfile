FROM ubuntu:20.04 AS builder

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    perl \
    make \
    automake  \
    autoconf  \
    m4  \
    libtool  \
    libtool-bin  \
    g++  \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app
WORKDIR /app

COPY . .

RUN bash ./autogen.sh && \
    bash ./configure --prefix=/opt/sockperf && \
    make -j4 && \
    make install

ENTRYPOINT ["/opt/sockperf/bin/sockperf"]
