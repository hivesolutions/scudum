#!/bin/bash
# -*- coding: utf-8 -*-

set -e

source $DIR/base/config.sh

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
