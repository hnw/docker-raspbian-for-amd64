#!/bin/bash
#
#     Create a docker image raspbian distribution image for raspberry-pi
#

set -e
docker build -t x86_64_stretch-qemu-arm .
docker run --privileged -v $(pwd):/opt/tmp/ -w /opt/tmp x86_64_stretch-qemu-arm:latest ./export-raspbian-img.sh

DISK_IMG=$(ls *.tar | sed 's/.tar$//')
RASPBIAN_VERSION=$(echo $DISK_IMG | sed 's/^.*-raspbian-//' | sed 's/-.*$//')
DOCKER_REPO=$(echo $DISK_IMG | sed 's/^.*-raspbian/raspbian/' | sed 's/-'$RASPBIAN_VERSION'//')-for-x86_64
DOCKER_TAG=$RASPBIAN_VERSION-$(echo $DISK_IMG | sed 's/-raspbian.*$//')

docker import $DISK_IMG.tar $DOCKER_REPO:$DOCKER_TAG
