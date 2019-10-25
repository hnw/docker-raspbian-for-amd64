FROM debian:stretch

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update \
 && apt-get -y install \
        binfmt-support qemu qemu-user-static wget unzip \
 && rm -rf /var/lib/apt/lists/*
