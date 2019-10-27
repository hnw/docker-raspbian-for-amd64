#!/bin/bash
#
#     Create a docker image raspbian distribution image for raspberry-pi
#
# Change the SRC path if needed:
SRC=http://ftp.jaist.ac.jp/pub/raspberrypi/raspbian_lite/images/raspbian_lite-2019-09-30/2019-09-26-raspbian-buster-lite.zip

set -e

apt-get -y update
apt-get -y install qemu qemu-user-static wget unzip

mkdir -p raspbian-tmp
cd raspbian-tmp
echo Download image...
wget --trust-server-names $SRC
unzip *.zip && rm *.zip
DISK_IMG=$(ls *.img | sed 's/.img$//')
OFFSET=$(fdisk -lu $DISK_IMG.img | sed -n "s/\(^[^ ]*img2\)\s*\([0-9]*\)\s*\([0-9]*\)\s*\([0-9]*\).*/\2/p")
mkdir -p root
mount -o loop,offset=$(($OFFSET*512)) $DISK_IMG.img root
# Disable preloaded shared library to get everything including networking to work on x86
mv root/etc/ld.so.preload root/etc/ld.so.preload.bak

# Copy qemu-arm-static in the image be able to interpret arm elf on x86
cp /usr/bin/qemu-arm-static root/usr/bin

# Archive Raspbian root
echo Archiving Raspbian root...
cd root
tar cf ../../$DISK_IMG.tar .
cd ..

# Clean-up
umount root
rmdir root
rm $DISK_IMG.img
