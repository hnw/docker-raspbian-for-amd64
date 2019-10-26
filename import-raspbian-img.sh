#!/bin/bash

set -e

DISK_IMG=$(ls *.tar | sed 's/.tar$//')
RASPBIAN_VERSION=$(echo $DISK_IMG | sed 's/^.*-raspbian-//' | sed 's/-.*$//')
DOCKER_REPO=$(echo $DISK_IMG | sed 's/^.*-raspbian/raspbian/' | sed 's/-'$RASPBIAN_VERSION'//')-for-x86_64
DOCKER_TAG=$RASPBIAN_VERSION-$(echo $DISK_IMG | sed 's/-raspbian.*$//')

docker import $DISK_IMG.tar $DOCKER_REPO:$DOCKER_TAG

echo Test the image with:
echo docker run --rm $DOCKER_REPO:$DOCKER_TAG /bin/bash -c 'uname -a'
docker run --rm $DOCKER_REPO:$DOCKER_TAG /bin/bash -c 'uname -a'
docker run --rm $DOCKER_REPO:$DOCKER_TAG /bin/bash -c 'ps auxwwg'
