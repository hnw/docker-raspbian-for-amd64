#!/bin/bash

set -e

apt-get -y update
apt-get -y install qemu qemu-user-static wget unzip
