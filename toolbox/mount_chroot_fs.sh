#!/bin/sh
mount -t proc proc chroot_dir/proc
mount -t sysfs sys chroot_dir/sys
mount -o bind /dev chroot_dir/dev
