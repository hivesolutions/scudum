#!/bin/bash
# -*- coding: utf-8 -*-

DEV_NAME=${DEV_NAME-/dev/sdb}
DEV_BOOT=${DEV_BOOT-"$DEV_NAME"1}
DEV_ROOT=${DEV_ROOT-"$DEV_NAME"3}
SCUDUM=${SCUDUM-/mnt/scudum}

mkdir -pv $SCUDUM
mount -v $DEV_ROOT $SCUDUM
mkdir -pv $SCUDUM/boot
mount -v $DEV_BOOT $SCUDUM/boot

mount -v --bind /dev $SCUDUM/dev
mount -vt devpts devpts $SCUDUM/dev/pts
mount -vt proc proc $SCUDUM/proc
mount -vt sysfs sysfs $SCUDUM/sys

chroot $SCUDUM /usr/bin/env -i\
    HOME=/root TERM="$TERM" PS1='\u:\w\$ '\
    PATH=/bin:/usr/bin:/sbin:/usr/sbin\
    /bin/bash --login

sync
umount -v $SCUDUM/sys
umount -v $SCUDUM/proc
umount -v $SCUDUM/dev/pts
umount -v $SCUDUM/dev

umount -v $SCUDUM/boot && rm -rvf $SCUDUM/boot
umount -v $SCUDUM && rm -rvf $SCUDUM
