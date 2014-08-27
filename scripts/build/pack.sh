#!/bin/bash
# -*- coding: utf-8 -*-

NAME=${NAME-scudum}
VERSION=${VERSION-v1}
DATE=${DATE-$(date +%Y%m%d)}

FULL_NAME="$NAME-$VERSION-$DATE.tar.gz"

set -e

BASE=$(pwd)

source base/config.sh

rm -rf $SCUDUM/tools
rm -rf $SCUDUM/sources

mountpoint -q $SCUDUM/sys && umount $SCUDUM/sys
mountpoint -q $SCUDUM/proc && umount $SCUDUM/proc
mountpoint -q $SCUDUM/dev/pts && umount $SCUDUM/dev/pts
mountpoint -q $SCUDUM/dev && umount $SCUDUM/dev

cd $SCUDUM/root
rm -rf .[^.] .??* *

cd $SCUDUM/tmp
rm -rf .[^.] .??* *

rm -rf $SCUDUM/scd/*
rm -rf $SCUDUM/source
rm -rf $SCUDUM/extra
rm -rf $SCUDUM/sources
rm -rf $SCUDUM/extras
rm -rf $SCUDUM/lost+found
rm -rf $SCUDUM/boot/lost+found
rm -f $SCUDUM/boot/initrd.img
rm -f $SCUDUM/isolinux/initrd.img
rm -f $SCUDUM/boot/grub/grub.cfg
rm -f $SCUDUM/etc/ssh/ssh_host_*

find $SCUDUM -name "*.pyc" -delete

find $SCUDUM/{,usr/,initrd/}{bin,lib,sbin} -type f -exec strip --strip-debug "{}" ";" || true

cd $BASE

tar -zcvf $FULL_NAME $SCUDUM/*
