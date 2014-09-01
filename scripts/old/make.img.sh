#!/bin/bash
# -*- coding: utf-8 -*-

FILE=${FILE-scudum.img}
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

if [ "$REBUILD" == "1" ]; then
    dd if=/dev/zero of=$DEV_NAME count=1

    DEV_NAME=$DEV_NAME BOOT_SIZE=$BOOT_SIZE\
        SWAP_SIZE=$SWAP_SIZE LOADER=$LOADER VERSION=$VERSION $DIR/install.dev.sh
fi

dd if=$DEV_NAME of=$FILE bs=1M

if [ "$REBUILD" == "1" ]; then
    dd if=/dev/zero of=$DEV_NAME count=1
fi
