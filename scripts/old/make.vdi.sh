#!/bin/bash
# -*- coding: utf-8 -*-

FILE_IN=${FILE_IN-scudum.img}
FILE_OUT=${FILE_IN-scudum.vdi}
DEV_NAME=${DEV_NAME-/dev/null}
BOOT_SIZE=${BOOT_SIZE-+1G}
SWAP_SIZE=${SWAP_SIZE-+2G}
LOADER=${LOADER-grub}
VERSION=${VERSION-latest}
REBUILD=${REBUILD-0}

DIR=$(dirname $(readlink -f $0))

if [ "$DEV_NAME" == "/dev/null" ]; then
    echo "DEV_NAME not specified, it's required"
    exit 1
fi

FILE=$FILE_IN DEV_NAME=$DEV_NAME BOOT_SIZE=$BOOT_SIZE\
    SWAP_SIZE=$SWAP_SIZE LOADER=$LOADER VERSION=$VERSION\
    REBUILD=$REBUILD $DIR/make.img.sh

VBoxManage convertfromraw --format VDI $FILE_IN $FILE_OUT
rm -v $FILE_IN
