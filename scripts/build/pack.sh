#!/bin/bash
# -*- coding: utf-8 -*-

NAME=${NAME-scudum}
VERSION=${VERSION-v1}
DATE=${DATE-$(date +%y%m%d%H%M)}

FULL_NAME="$NAME_$VERSION_$DATE.tar.gz"

set -e

source base/config.sh

rm -rf $SCUDUM/tools
rm -rf $SCUDUM/sources

mountpoint -q $SCUDUM/sys && umount $SCUDUM/sys
mountpoint -q $SCUDUM/proc && umount $SCUDUM/proc
mountpoint -q $SCUDUM/dev/pts && umount $SCUDUM/dev/pts
mountpoint -q $SCUDUM/dev && umount $SCUDUM/dev

tar -zcvf $FULL_NAME $SCUDUM/*
