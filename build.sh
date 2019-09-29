#!/bin/bash
set -ex

mkdir ramdisk
mount -t tmpfs tmpfs ramdisk
cd ramdisk

mkdir chroot
DEBIAN_FRONTEND=noninteractive apt-get install debootstrap -y
debootstrap --arch=i386 --components=main,universe,multiverse --variant=minbase --include=zlib1g-dev,libgl1-mesa-dev,libjpeg-dev,libpng-dev,libssl-dev,libglu1-mesa-dev,libglew-dev,libsdl1.2-dev,libsdl-mixer1.2-dev,libfreetype6-dev,freeglut3-dev,libxpm-dev,cmake,make,git,software-properties-common,libgtk2.0-dev --exclude=init,init-system-helpers,initramfs-tools,initramfs-tools-bin,initramfs-tools-core bionic chroot http://us-central1.gce.archive.ubuntu.com/ubuntu 

../setup_chroot.sh
chroot chroot add-apt-repository -y ppa:ubuntu-toolchain-r/test
chroot chroot apt-get install --no-install-recommends -y gcc-9 g++-9
chroot chroot update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 1
chroot chroot update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 1

../unmount_chroot.sh
tar cJf chroot.tar.xz chroot
