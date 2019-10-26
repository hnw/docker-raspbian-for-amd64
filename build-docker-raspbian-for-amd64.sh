#!/bin/bash
#
#     Create a docker image raspbian distribution image for raspberry-pi
#

set -e
docker build -t x86_64_stretch-qemu-arm .
docker run --privileged -v $(pwd):/opt/tmp/ -w /opt/tmp x86_64_stretch-qemu-arm:latest ./export-raspbian-img.sh

./import-raspbian-img.sh
