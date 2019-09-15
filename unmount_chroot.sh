#!/bin/bash
set -e
umount chroot/proc
umount chroot/sys
umount chroot/dev/pts
umount chroot/dev
