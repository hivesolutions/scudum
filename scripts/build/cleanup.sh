#!/bin/bash
# -*- coding: utf-8 -*-

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/base/config.sh

if [ -e $SCUDUM/config ]; then
    source $SCUDUM/config
fi

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

if [ -e $SCUDUM/bin/bash.old ]; then
    ln -sf bash $SCUDUM/bin/sh
    rm -f $SCUDUM/bin/bash.old
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

if [ "$SCUDUM_CROSS" == "0" ]; then
    find $SCUDUM/{,usr/,initrd/}{bin,lib,sbin} -type f -exec strip --strip-debug "{}" ";" || true
fi

if [ "$SCUDUM_CROSS" == "1" ]; then
    sed -i 's/\/tools\/bin/\/usr\/bin/' /usr/bin/{autom4te,autoheader,autoreconf,autoscan,autoupdate,ifnames}
    sed -i 's/\/tools\/bin/\/usr\/bin/' /usr/bin/{aclocal,automake}
    sed -i 's/\/tools\/bin/\/usr\/bin/' /usr/bin/ldd
    sed -i 's/\/tools\/bin/\/usr\/bin/' /usr/bin/{afmtodit,gropdf}
fi
