#!/bin/bash
# -*- coding: utf-8 -*-

FILE=${FILE-scudum.img}
PEN_NAME=${PEN_NAME-/dev/sdc}
DEV_NAME=${DEV_NAME-/dev/null}
BOOT_SIZE=${BOOT_SIZE-+1G}
SWAP_SIZE=${SWAP_SIZE-+2G}
NAME=${NAME-scudum}
SCUDUM=${SCUDUM-/tmp/scudum}
SCUDUM_PEN=${SCUDUM_PEN-/tmp/scudum-pen}
TARGET=${TARGET-/mnt/drop/$NAME}
LOADER=${LOADER-isolinux}
VERSION=${VERSION-latest}
REBUILD=${REBUILD-0}
DEPLOY=${DEPLOY-1}
SQUASH=${SQUASH-1}
WINDOWS=${WINDOWS-1}
SLEEP_TIME=3

PEN_ROOT="$PEN_NAME"1
DEV_BOOT="$DEV_NAME"1
DEV_SWAP="$DEV_NAME"2
DEV_ROOT="$DEV_NAME"3

CUR=$(pwd)
DIR=$(dirname $(readlink -f $0))

if [ "$DEV_NAME" == "/dev/null" ]; then
    echo "DEV_NAME not specified, it's required"
    exit 1
fi

if [ "$REBUILD" == "1" ]; then
    dd if=/dev/zero of=$DEV_NAME count=1

    DEV_NAME=$DEV_NAME BOOT_SIZE=$BOOT_SIZE SWAP_SIZE=$SWAP_SIZE\
        SCUDUM=$SCUDUM LOADER=$LOADER VERSION=$VERSION $DIR/install.dev.sh
fi

mkdir -pv $SCUDUM
mount -v $DEV_ROOT $SCUDUM
if [ $DEV_ROOT != $DEV_BOOT ]; then
    mkdir -pv $SCUDUM/boot
    mount -v $DEV_BOOT $SCUDUM/boot
fi

SCUDUM=$SCUDUM TARGET=/boot $DIR/initrd.sh

cd $SCUDUM
tar -zcf images/root.tar.gz root
tar -zcf images/dev.tar.gz dev
tar -zcf images/etc.tar.gz etc
cd $CUR

if [ "$SQUASH" == "1" ]; then
    ISO_DIR=/tmp/$NAME.iso.dir

    mksquashfs $SCUDUM $NAME.sqfs
    mkdir -pv $ISO_DIR
    cp -rp $SCUDUM/boot $ISO_DIR
    mv $NAME.sqfs $ISO_DIR
else
    ISO_DIR=$SCUDUM
fi

dd if=/dev/zero of=$PEN_NAME count=1

if [ "$WINDOWS" == "1" ]; then
    (echo n; echo p; echo 1; echo ; echo ; echo a; echo 1; echo t; echo c; echo w) | fdisk -H 255 -S 63 $PEN_NAME
else
    (echo n; echo p; echo 1; echo ; echo ; echo a; echo 1; echo w) | fdisk -H 255 -S 63 $PEN_NAME
fi
sleep $SLEEP_TIME && sync

if [ "$WINDOWS" == "1" ]; then
    mkfs.vfat -F 32 -n $NAME $PEN_ROOT && rm -rf $PEN_ROOT/lost+found
else
    mkfs.ext4 -L $NAME $PEN_ROOT && rm -rf $PEN_ROOT/lost+found
fi

mkdir -pv $SCUDUM_PEN
mount -v $PEN_ROOT $SCUDUM_PEN
cp -rp $ISO_DIR/* $SCUDUM_PEN

if [ "$WINDOWS" == "1" ]; then
    dd if=/usr/lib/syslinux/mbr.bin conv=notrunc\
        bs=440 count=1 of=$PEN_NAME
    syslinux --stupid --directory /boot $PEN_ROOT && sync
else
    dd if=/usr/lib/syslinux/mbr.bin conv=notrunc\
        bs=440 count=1 of=$PEN_NAME
    extlinux --heads=255 --sectors=63 --install $SCUDUM_PEN/boot && sync
fi

sync
umount -v $SCUDUM_PEN && rm -rvf $SCUDUM_PEN

if [ "$SQUASH" == "1" ]; then
    rm -rf $ISO_DIR
fi

if [ "$DEPLOY" == "1" ]; then
    dd if=$PEN_NAME of=$FILE bs=1M
    mv $FILE $TARGET
fi

rm -v $SCUDUM/boot/initrd.img
rm -v $SCUDUM/images/root.tar.gz
rm -v $SCUDUM/images/dev.tar.gz
rm -v $SCUDUM/images/etc.tar.gz

sync
if [ $DEV_ROOT != $DEV_BOOT ]; then
    umount -v $SCUDUM/boot && rm -rvf $SCUDUM/boot
fi
umount -v $SCUDUM && rm -rvf $SCUDUM

if [ "$REBUILD" == "1" ]; then
    dd if=/dev/zero of=$DEV_NAME count=1
fi
