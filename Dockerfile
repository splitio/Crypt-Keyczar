FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update

RUN apt-get install -y locales

RUN locale-gen \
    en_US.UTF-8 &&\
    update-locale LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8

RUN apt-get -y install \
    build-essential \
    libssl-dev \
    libjson-perl \
    bash-completion \
    sudo

COPY . /usr/src/keyzcar/

WORKDIR /usr/src/keyzcar

RUN perl Makefile.PL &&\
    make test &&\
    make install

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos "ubuntu" ubuntu && \
    adduser ubuntu sudo && \
    echo "ubuntu ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    touch /home/ubuntu/.sudo_as_admin_successful && \
    chown -R root:sudo /usr/local

RUN cp /home/ubuntu/.bashrc /root/.bashrc

WORKDIR /home/ubuntu

ENV TERM=xterm-256color

USER ubuntu

ENTRYPOINT ["keyczar"]
