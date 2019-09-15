#!/bin/bash
set -e
mount -o bind /dev chroot/dev
mount -o bind /dev/pts chroot/dev/pts
mount -t sysfs /sys chroot/sys
mount -t proc /proc chroot/proc
cp /proc/mounts chroot/etc/mtab
cp /etc/resolv.conf chroot/etc/resolv.conf
