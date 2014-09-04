#!/bin/bash
# -*- coding: utf-8 -*-

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/base/config.sh

cd $SCUDUM/root
find . ! -name ".bashrc" -delete

cd $SCUDUM/tmp
find . -delete

rm -rf $SCUDUM/scd/*
rm -rf $SCUDUM/opt
rm -rf $SCUDUM/source
rm -rf $SCUDUM/extra
rm -rf $SCUDUM/tools
rm -rf $SCUDUM/sources
rm -rf $SCUDUM/images
rm -rf $SCUDUM/extras
rm -rf $SCUDUM/lost+found
rm -rf $SCUDUM/boot/lost+found
rm -f $SCUDUM/boot/grub/grub.cfg
rm -f $SCUDUM/etc/ssh/ssh_host_*

find $SCUDUM -name "*.pyc" -delete

find $SCUDUM/{,usr/,initrd/}{bin,lib,sbin} -type f -exec strip --strip-debug "{}" ";" || true
