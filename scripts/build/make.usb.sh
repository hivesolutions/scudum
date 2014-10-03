#!/bin/bash
# -*- coding: utf-8 -*-

NAME=${NAME-scudum}
VERSION=${VERSION-$(date +%Y%m%d)}
LABEL=${LABEL-SCUDUM}
PREFIX=${PREFIX-/usr}
BASE=${BASE-/mnt/builds}
TARGET=${TARGET-$BASE/$NAME/usb}
SCHEMA=${SCHEMA-transient}
SIZE=${SIZE-1073741824}
OFFSET_SECTORS=${OFFSET_SECTORS-2048}
BLOCK_SIZE=${BLOCK_SIZE-4096}
HEADS=${HEADS-255}
SECTORS=${SECTORS-63}
BYTES_SECTOR=${BYTES_SECTOR-512}
CONFIG=${CONFIG-1}
CLEANUP=${CLEANUP-1}
DEPLOY=${DEPLOY-0}
SQUASH=${SQUASH-1}
AUTORUN=${AUTORUN-1}

CUR=$(pwd)
DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))
OFFSET=$(expr $OFFSET_SECTORS \* $BYTES_SECTOR)
BLOCK_COUNT=$(expr $SIZE / $BLOCK_SIZE)

SLEEP_TIME=3
MOUNT_DIR=/tmp/$NAME.mount

set -e +h

source $DIR/base/config.sh

echo "make.usb: $HEADS heads, $SECTORS sectors, $BYTES_SECTOR bytes/sector"
echo "make.usb: $OFFSET ($OFFSET_SECTORS) offset"

DISTRIB=${DISTRIB-$(cat $SCUDUM/etc/scudum/DISTRIB)}

if [ "$DISTRIB" == "generic" ]; then
    FILE=${FILE-$NAME-$VERSION.usb.img}
else
    FILE=${FILE-$NAME-$DISTRIB-$VERSION.usb.img}
fi

if type apt-get &> /dev/null; then
    apt-get -y install syslinux squashfs-tools dosfstools mtools kpartx
elif type scu &> /dev/null; then
    scu install syslinux squashfs-tools dosfstools mtools kpartx
else
    exit 1
fi

if [ "$CONFIG" == "1" ]; then
    SCHEMA=$SCHEMA $DIR/config.sh
fi

if [ ! -e $SCUDUM/etc/scudum/CONFIGURED ]; then
    echo "make.usb: scudum not configured, not possible to make USB"
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
    mksquashfs $SCUDUM data.sqfs
    mkdir -pv $IMG_DIR
    cp -rp $SCUDUM/boot $IMG_DIR
    mv -v data.sqfs $IMG_DIR
else
    IMG_DIR=$SCUDUM
fi

if [ "$AUTORUN" == "1" ]; then
    cp -v $SCUDUM/isolinux/autorun.inf $IMG_DIR
    cp -v $SCUDUM/isolinux/scudum.ico $IMG_DIR
fi

dd if=/dev/zero of=$FILE bs=$BLOCK_SIZE count=$BLOCK_COUNT && sync

(echo n; echo p; echo 1; echo ; echo ; echo a; echo 1; echo t; echo c; echo w) | fdisk -H $HEADS -S $SECTORS $FILE
sleep $SLEEP_TIME && sync

dd if=$PREFIX/lib/syslinux/mbr.bin of=$FILE conv=notrunc bs=440 count=1 && sync

DEV_LOOP_BASE=$(kpartx -l $FILE | sed -n 1p | cut -f 1 -d " ")
DEV_LOOP=/dev/mapper/$DEV_LOOP_BASE

kpartx -a $FILE && sync

mkfs.vfat -h $OFFSET_SECTORS -F 32 -I -n $LABEL $DEV_LOOP && sync
mlabel -i $DEV_LOOP ::$LABEL && sync

mkdir -pv $MOUNT_DIR
mount -v $DEV_LOOP $MOUNT_DIR && sync

cp -rp $IMG_DIR/* $MOUNT_DIR

umount -v $MOUNT_DIR && sync
rm -rf $MOUNT_DIR

syslinux --install $DEV_LOOP && sync

kpartx -d $FILE && sync

if [ "$AUTORUN" == "1" ]; then
    rm -v $IMG_DIR/autorun.inf
    rm -v $IMG_DIR/scudum.ico
fi

if [ "$SQUASH" == "1" ]; then
    rm -rf $IMG_DIR
fi

if [ "$DEPLOY" == "1" ]; then
    mkdir -pv $TARGET && mv -v $FILE $TARGET
fi

rm -rv $SCUDUM/images
