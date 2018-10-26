#!/bin/bash
# -*- coding: utf-8 -*-

NAME=${NAME-scudum}
LABEL=${LABEL-SCUDUM}
PREFIX=${PREFIX-/usr}
BASE=${BASE-/mnt/builds}
TARGET=${TARGET-$BASE/$NAME/rasp}
SCHEMA=${SCHEMA-transient}
KVARIANT=${KVARIANT-rasp}
SIZE=${SIZE-1073741824}
OFFSET_SECTORS=${OFFSET_SECTORS-2048}
BLOCK_SIZE=${BLOCK_SIZE-4096}
HEADS=${HEADS-255}
SECTORS=${SECTORS-63}
BYTES_SECTOR=${BYTES_SECTOR-512}
BASIC_INITRD=${BASIC_INITRD-1}
LARGE_INITRD=${LARGE_INITRD-0}
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

if [ -e $SCUDUM/config ]; then
    source $SCUDUM/config
fi

echo "make.rasp: $HEADS heads, $SECTORS sectors, $BYTES_SECTOR bytes/sector"
echo "make.rasp: $OFFSET ($OFFSET_SECTORS) offset"

DISTRIB=${DISTRIB-$(cat $SCUDUM/etc/scudum/DISTRIB)}

if [ "$DISTRIB" == "generic" ]; then
    FILE=${FILE-$NAME-$SCUDUM_ARCH-$VERSION.rasp.img}
    FILE_LATEST=${FILE_LATEST-$NAME-$SCUDUM_ARCH-latest.rasp.img}
else
    FILE=${FILE-$NAME-$DISTRIB-$SCUDUM_ARCH-$VERSION.rasp.img}
    FILE_LATEST=${FILE_LATEST-$NAME-$DISTRIB-$SCUDUM_ARCH-latest.rasp.img}
fi

if type apt-get &> /dev/null; then
    apt-get -y install squashfs-tools dosfstools mtools kpartx
elif type scu &> /dev/null; then
    env -u VERSION scu install squashfs-tools dosfstools mtools kpartx
else
    exit 1
fi

if [ "$CONFIG" == "1" ]; then
    SCHEMA=$SCHEMA KVARIANT=$KVARIANT $DIR/config.sh
fi

if [ ! -e $SCUDUM/etc/scudum/CONFIGURED ]; then
    echo "make.rasp: scudum not configured, not possible to make rasp"
    exit 1
fi

if [ "$SCUDUM_BARCH" != "arm" ]; then
    echo "make.rasp: scudum is not built for arm, not possible to make rasp"
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
    mksquashfs $(readlink -f $SCUDUM) $NAME.sqfs
    mkdir -pv $IMG_DIR
    cp -rp $SCUDUM/boot $IMG_DIR
    mv -v $NAME.sqfs $IMG_DIR
else
    IMG_DIR=$SCUDUM
fi

if [ "$AUTORUN" == "1" ]; then
    cp -v $SCUDUM/isolinux/autorun.inf $IMG_DIR
    cp -v $SCUDUM/isolinux/scudum.ico $IMG_DIR
fi

cp -rpv $SCUDUM/rasp/* $IMG_DIR
cp -pv $SCUDUM/boot/vmlinuz $IMG_DIR/kernel.img

if [ -e $SCUDUM/boot/vmlinuz7 ]; then
    cp -pv $SCUDUM/boot/vmlinuz7 $IMG_DIR/kernel7.img
fi

if [ "$BASIC_INITRD" == "1" ]; then
    cp -pv $SCUDUM/boot/initrd.basic.img $IMG_DIR/initrd.img
elif [ "$LARGE_INITRD" == "1" ]; then
    cp -pv $SCUDUM/boot/initrd.large.img $IMG_DIR/initrd.img
else
    cp -pv $SCUDUM/boot/initrd.img $IMG_DIR/initrd.img
fi

echo "make.rasp: intializing $FILE with $BLOCK_COUNT blocks of size $BLOCK_SIZE ($SIZE bytes)"

dd if=/dev/zero of=$FILE bs=$BLOCK_SIZE count=$BLOCK_COUNT && sync

(echo n; echo p; echo 1; echo ; echo ; echo a; echo 1; echo t; echo c; echo w) | fdisk -H $HEADS -S $SECTORS $FILE &> /dev/null
sleep $SLEEP_TIME && sync

DEV_MOUNT_PREVIEW=$(kpartx -l $FILE)
DEV_MOUNT_REAL=$(kpartx -v -a -s -f $FILE)

if [ "$DEV_MOUNT_REAL" != "" ]; then
    DEV_MOUNT=$DEV_MOUNT_REAL
    DEV_LOOP_BASE=$(echo $DEV_MOUNT_REAL | awk '{print $3}')
else
    DEV_MOUNT=$DEV_MOUNT_PREVIEW
    DEV_LOOP_BASE=$(echo $DEV_MOUNT_PREVIEW | awk '{print $1}')
fi

DEV_LOOP=/dev/mapper/$DEV_LOOP_BASE
DEV_LOOP_ROOT=/dev/${DEV_LOOP_BASE:0:-2}

sync

echo "make.rasp: kpartx executed with result '$DEV_MOUNT'"
echo "make.rasp: mounted $IMAGE on mappper partition $DEV_LOOP"

mkfs.vfat -h $OFFSET_SECTORS -F 32 -I -n $LABEL $DEV_LOOP && sync
MTOOLS_SKIP_CHECK=1 mlabel -i $DEV_LOOP ::$LABEL && sync

mkdir -pv $MOUNT_DIR
mount -v $DEV_LOOP -t vfat $MOUNT_DIR && sync

cp -rp $IMG_DIR/* $MOUNT_DIR && sync

umount -v $MOUNT_DIR && sync
rm -rf $MOUNT_DIR

kpartx -v -d $FILE && sync
kpartx -v -d $DEV_LOOP_ROOT > /dev/null 2>&1 && sync || true
losetup -d $DEV_LOOP_ROOT > /dev/null 2>&1 && sync || true

if [ "$AUTORUN" == "1" ]; then
    rm -v $IMG_DIR/autorun.inf
    rm -v $IMG_DIR/scudum.ico
fi

if [ "$SQUASH" == "1" ]; then
    rm -rf $IMG_DIR
fi

if [ "$DEPLOY" == "1" ]; then
    mkdir -pv $TARGET && mv -v $FILE $TARGET
    ln -svf $FILE $TARGET/$FILE_LATEST
fi

rm -rv $SCUDUM/images
