#!/bin/bash
set -e

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install debootstrap -y
mkdir chroot
debootstrap --arch=i386 --components=main,universe,multiverse bionic chroot http://de.archive.ubuntu.com/ubuntu

./setup_chroot.sh
chroot chroot apt-get update
chroot chroot apt-get install -y software-properties-common
chroot chroot add-apt-repository -y ppa:jonathonf/gcc-9.0
chroot chroot apt-get install -y gcc-9 g++-9

./unmount_chroot.sh
tar czf chroot.tar.gz chroot
