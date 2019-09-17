#!/bin/bash
set -e

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install debootstrap -y
mkdir chroot
debootstrap --arch=i386 --components=main,universe,multiverse bionic chroot http://us-central1.gce.archive.ubuntu.com/ubuntu

./setup_chroot.sh
chroot chroot apt-get update
chroot chroot apt-get install -y software-properties-common
chroot chroot add-apt-repository -y ppa:ubuntu-toolchain-r/test
chroot chroot apt-get install -y gcc zlib1g-dev build-essential libgl1-mesa-dev libjpeg-dev libpng-dev libssl-dev libglu1-mesa-dev libglew-dev libsdl1.2-dev libsdl-mixer1.2-dev libfreetype6-dev freeglut3-dev libxpm-dev cmake make git g++ gcc-9 g++-9
chroot chroot update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 1
chroot chroot update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 1

./unmount_chroot.sh
tar czf chroot.tar.gz chroot
