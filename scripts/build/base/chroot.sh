#!/bin/bash
# -*- coding: utf-8 -*-

# tries to retrieve the proper chroot (bash) arguments
# using the provided arguments if they exist or an interactive
# fallback approach otherwise (as expected)
CHROOT_ARGS=${CHROOT_ARGS---login +h}

# retrieves the reference to the current files directory
# so that it's possible to "write" the scripts as relative
DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/config.sh

mkdir -pv $SCUDUM/{dev,proc,sys}

# crates the main device nodes with the proper
# flags set for the devices (going to be re-used)
test ! -e $SCUDUM/dev/console &&\
    mknod -m 600 $SCUDUM/dev/console c 5 1
test ! -e $SCUDUM/dev/null &&\
    mknod -m 666 $SCUDUM/dev/null c 1 3

# verifies each of the special filesystems for
# mounting and in case they are mounted umounts
# them avoiding a duplicate re-mounting
mountpoint -q $SCUDUM/mnt/builds && umount -v $SCUDUM/mnt/builds
mountpoint -q $SCUDUM/sys && umount -v $SCUDUM/sys
mountpoint -q $SCUDUM/proc && umount -v $SCUDUM/proc
mountpoint -q $SCUDUM/run/shm && umount -v $SCUDUM/run/shm
mountpoint -q $SCUDUM/dev/shm && umount -v $SCUDUM/dev/shm
mountpoint -q $SCUDUM/dev/pts && umount -v $SCUDUM/dev/pts
mountpoint -q $SCUDUM/dev && umount -v $SCUDUM/dev

mount -v --bind /dev $SCUDUM/dev

mount -vt devpts devpts $SCUDUM/dev/pts -o gid=5,mode=620
mount -vt proc proc $SCUDUM/proc
mount -vt sysfs sysfs $SCUDUM/sys

sync

mkdir -pv $SCUDUM/etc
rm -f $SCUDUM/etc/resolv.conf
echo "nameserver 8.8.8.8" >> $SCUDUM/etc/resolv.conf

if [ -h $SCUDUM/dev/shm ]; then
    link=$(readlink $SCUDUM/dev/shm)
    mkdir -p $SCUDUM/$link
    mount -vt tmpfs shm $SCUDUM/$link
    unset link
else
    mount -vt tmpfs shm $SCUDUM/dev/shm
fi

trap "SCUDUM=$SCUDUM $DIR/release.sh" SIGINT SIGTERM

cp -rp $(readlink -f "$DIR/../../../../scudum") $SCUDUM/tools/repo

if [ "$SCUDUM_CROSS" == "1" ]; then
    TARGET_PATH=/cross/bin:/cross/sbin:/tools/bin:/tools/sbin:/bin:/usr/bin:/sbin:/usr/sbin
else
    TARGET_PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin
fi

chroot $SCUDUM /tools/bin/env -i\
    HOME=/root\
    TERM="$TERM"\
    PS1="\u:\w\$ "\
    PATH="$TARGET_PATH"\
    /tools/bin/bash $CHROOT_ARGS $@
result=$?

SCUDUM=$SCUDUM $DIR/release.sh

exit $result
