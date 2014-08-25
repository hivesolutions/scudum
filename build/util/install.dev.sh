#!/bin/bash
# -*- coding: utf-8 -*-

DEV_NAME=${DEV_NAME-/dev/null}
BOOT_SIZE=${BOOT_SIZE-+1G}
SWAP_SIZE=${SWAP_SIZE-+2G}
SCHEMA=${SCHEMA-stored}
LOADER=${LOADER-grub}
VERSION=${VERSION-latest}
SLEEP_TIME=3

DIR=$(dirname $(readlink -f $0))

if [ "$DEV_NAME" == "/dev/null" ]; then
    echo "DEV_NAME not specified, it's required"
    exit 1
fi

dd if=/dev/zero of=$DEV_NAME count=1

(echo n; echo p; echo 1; echo ; echo $BOOT_SIZE; echo a; echo 1; echo w) | fdisk -H 255 -S 63 $DEV_NAME
sleep $SLEEP_TIME && sync
(echo n; echo p; echo 2; echo ; echo $SWAP_SIZE; echo t; echo 2; echo 82; echo w) | fdisk -H 255 -S 63 $DEV_NAME
sleep $SLEEP_TIME && sync
(echo n; echo p; echo 3; echo ; echo ; echo w) | fdisk $DEV_NAME
sleep $SLEEP_TIME && sync

DEV_BOOT="$DEV_NAME"1
DEV_SWAP="$DEV_NAME"2
DEV_ROOT="$DEV_NAME"3

DEV_NAME=$DEV_NAME DEV_BOOT=$DEV_BOOT DEV_SWAP=$DEV_SWAP\
    DEV_ROOT=$DEV_ROOT SCHEMA=$SCHEMA LOADER=$LOADER VERSION=$VERSION $DIR/install.sh
