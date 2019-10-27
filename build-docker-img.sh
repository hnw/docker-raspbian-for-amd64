#!/bin/bash

set -e

DISK_IMG=$(ls *.tar | sed 's/.tar$//')
RASPBIAN_VERSION=$(echo $DISK_IMG | sed 's/^.*-raspbian-//' | sed 's/-.*$//')
DOCKER_TAG=$RASPBIAN_VERSION-$(echo $DISK_IMG | sed 's/-raspbian.*$//')
DOCKER_IMAGE=$DOCKERHUB_USER/$DOCKERHUB_REPO

docker import $DISK_IMG.tar $DOCKER_IMAGE:latest
docker tag $DOCKER_IMAGE:latest $DOCKER_IMAGE:$DOCKER_TAG

echo Test the image with:
echo docker run --rm $DOCKER_IMAGE:latest /bin/bash -c 'uname -a'
docker run --rm $DOCKER_IMAGE:latest /bin/bash -c 'uname -a'
