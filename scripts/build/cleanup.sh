#!/bin/bash
# -*- coding: utf-8 -*-

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/base/config.sh

mountpoint -q $SCUDUM/mnt/builds && umount -v $SCUDUM/mnt/builds
mountpoint -q $SCUDUM/sys && umount -v $SCUDUM/sys
mountpoint -q $SCUDUM/proc && umount -v $SCUDUM/proc
mountpoint -q $SCUDUM/run/shm && umount -v $SCUDUM/run/shm
mountpoint -q $SCUDUM/dev/shm && umount -v $SCUDUM/dev/shm
mountpoint -q $SCUDUM/dev/pts && umount -v $SCUDUM/dev/pts
mountpoint -q $SCUDUM/dev && umount -v $SCUDUM/dev

sync

if [ -d $SCUDUM/root ]; then
    cd $SCUDUM/root
    find . ! -name ".bashrc" -delete
fi

if [ -d $SCUDUM/tmp ]; then
    cd $SCUDUM/tmp
    find . -delete
fi

rm -rf $SCUDUM/pst
rm -rf $SCUDUM/opt
rm -rf $SCUDUM/extra
rm -rf $SCUDUM/cross
rm -rf $SCUDUM/tools
rm -rf $SCUDUM/images
rm -rf $SCUDUM/extras
rm -rf $SCUDUM/source
rm -rf $SCUDUM/sources
rm -rf $SCUDUM/lost+found
rm -rf $SCUDUM/boot/lost+found
rm -f $SCUDUM/etc/ssh/ssh_host_*

find $SCUDUM -name "*.pyc" -delete

find $SCUDUM/{,usr/,initrd/}{bin,lib,sbin} -type f -exec strip --strip-debug "{}" ";" || true
