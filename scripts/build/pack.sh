#!/bin/bash
# -*- coding: utf-8 -*-

NAME=${NAME-scudum}
VERSION=${VERSION-$(date +%Y%m%d)}
FILE=${FILE-$NAME-$VERSION.tar.gz}

BASE=$(pwd)
DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/base/config.sh

if [ -e $SCUDUM/config ]; then
    source $SCUDUM/config
fi

if [ -e $SCUDUM/etc/scudum/CONFIGURED ]; then
    echo "Scudum already configured, not possible to pack"
    exit 1
fi

mountpoint -q $SCUDUM/mnt/builds && umount $SCUDUM/mnt/builds
mountpoint -q $SCUDUM/sys && umount $SCUDUM/sys
mountpoint -q $SCUDUM/proc && umount $SCUDUM/proc
mountpoint -q $SCUDUM/run/shm && umount $SCUDUM/run/shm
mountpoint -q $SCUDUM/dev/shm && umount $SCUDUM/dev/shm
mountpoint -q $SCUDUM/dev/pts && umount $SCUDUM/dev/pts
mountpoint -q $SCUDUM/dev && umount $SCUDUM/dev

sync

cd $SCUDUM/root
find . -delete

cd $SCUDUM/tmp
find . -delete

rm -rf $SCUDUM/pst
rm -rf $SCUDUM/opt
rm -rf $SCUDUM/extra
rm -rf $SCUDUM/images
rm -rf $SCUDUM/extras
rm -rf $SCUDUM/source
rm -rf $SCUDUM/sources
rm -rf $SCUDUM/lost+found
rm -rf $SCUDUM/boot/lost+found
rm -f $SCUDUM/boot/vmlinuz
rm -f $SCUDUM/boot/initrd.img
rm -f $SCUDUM/boot/grub/grub.cfg
rm -f $SCUDUM/etc/ssh/ssh_host_*

find $SCUDUM -name "*.pyc" -delete

if [ "$SCUDUM_CROSS" == "1" ]; then
    strip=$SCUDUM/cross/bin/$ARCH_TARGET-strip
else
    strip=strip
fi

find $SCUDUM/{,usr/,initrd/}{bin,lib,sbin} -type f -exec $strip --strip-debug "{}" ";" || true

if [ "$SCUDUM_CROSS" == "0" ]; then
    rm -rf $SCUDUM/cross
    rm -rf $SCUDUM/tools
fi

cd $SCUDUM

rm -f $BASE/$FILE
tar -zcvf $BASE/$FILE *
