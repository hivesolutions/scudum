#!/bin/bash
# -*- coding: utf-8 -*-

NAME=${NAME-scudum}
VERSION=${VERSION-$(date +%Y%m%d)}
LABEL=${LABEL-Scudum}
PREFIX=${PREFIX-/usr}
BASE=${BASE-/mnt/builds}
TARGET=${TARGET-$BASE/$NAME/usb}
SCHEMA=${SCHEMA-transient}
SIZE=${SIZE-1073741824}
OFFSET=${OFFSET-1048576}
BLOCK_SIZE=${BLOCK_SIZE-4096}
CONFIG=${CONFIG-1}
CLEANUP=${CLEANUP-1}
DEPLOY=${DEPLOY-0}
SQUASH=${SQUASH-1}

CUR=$(pwd)
DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))
SIZE_B=$(expr $SIZE / $BLOCK_SIZE)

SLEEP_TIME=3
MOUNT_DIR=/tmp/$NAME.mount

set -e +h

source $DIR/base/config.sh

DISTRIB=${DISTRIB-$(cat $SCUDUM/etc/scudum/DISTRIB)}

if [ "$DISTRIB" == "generic" ]; then
    FILE=${FILE-$NAME-$VERSION.usb.img}
else
    FILE=${FILE-$NAME-$DISTRIB-$VERSION.usb.img}
fi

if type apt-get &> /dev/null; then
    apt-get -y install syslinux squashfs-tools dosfstools
elif type scu &> /dev/null; then
    scu install syslinux squashfs-tools dosfstools
else
    exit 1
fi

if [ "$CONFIG" == "1" ]; then
    SCHEMA=$SCHEMA $DIR/config.sh
fi

if [ ! -e $SCUDUM/etc/scudum/CONFIGURED ]; then
    echo "Scudum not configured, not possible to make USB"
    exit 1
fi

if [ "$CLEANUP" == "1" ]; then
    $DIR/cleanup.sh
fi

cd $SCUDUM

rm -rfv images && mkdir -pv images
tar -zcf images/root.tar.gz root
tar -zcf images/dev.tar.gz dev
tar -zcf images/etc.tar.gz etc

cd $CUR

if [ "$SQUASH" == "1" ]; then
    IMG_DIR=/tmp/$NAME.iso.dir
    mksquashfs $SCUDUM $NAME.sqfs
    mkdir -pv $IMG_DIR
    cp -rp $SCUDUM/boot $IMG_DIR
    mv $NAME.sqfs $IMG_DIR
else
    IMG_DIR=$SCUDUM
fi

dd if=/dev/zero of=$FILE bs=$BLOCK_SIZE count=$SIZE_B && sync
dd if=$PREFIX/lib/syslinux/mbr.bin conv=notrunc bs=440 count=1 of=$FILE && sync

(echo n; echo p; echo 1; echo ; echo ; echo a; echo 1; echo t; echo c; echo w) | fdisk -H 255 -S 63 $FILE
sleep $SLEEP_TIME && sync

DEV_NAME=$(losetup -f --show $FILE)
DEV_INDEX=${DEV_NAME:${#DEV_NAME} - 1}
DEV_MAIN=/dev/loop$(expr $DEV_INDEX + 1)

losetup --verbose --offset $OFFSET $DEV_MAIN $DEV_NAME

mkfs.vfat -F 32 $DEV_MAIN && sync
mlabel -i $DEV_MAIN ::$LABEL && sync

mkdir -pv $MOUNT_DIR
mount -v $DEV_MAIN $MOUNT_DIR

cp -rp $IMG_DIR/* $MOUNT_DIR

syslinux --install --mbr --active --force --directory /boot/syslinux $DEV_MAIN

umount -v $MOUNT_DIR
rm -rf $MOUNT_DIR

losetup -dv $DEV_MAIN
losetup -dv $DEV_NAME

if [ "$SQUASH" == "1" ]; then
    rm -rf $ISO_DIR
fi

if [ "$DEPLOY" == "1" ]; then
    mkdir -p $TARGET && mv $FILE $TARGET
fi

rm -rv $SCUDUM/images
