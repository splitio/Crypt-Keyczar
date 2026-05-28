# Build stage
FROM ubuntu:18.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    libssl-dev \
    libjson-perl \
    perl && \
    rm -rf /var/lib/apt/lists/*

COPY . /usr/src/keyczar/

WORKDIR /usr/src/keyczar

RUN perl Makefile.PL && \
    make test && \
    make install

# Runtime stage
FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y install \
    libssl1.1 \
    libjson-perl \
    perl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/lib/x86_64-linux-gnu/perl/ /usr/local/lib/x86_64-linux-gnu/perl/
COPY --from=builder /usr/local/bin/keyczar /usr/local/bin/keyczar

RUN useradd -m ubuntu
USER ubuntu
WORKDIR /home/ubuntu

ENTRYPOINT ["keyczar"]
