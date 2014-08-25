#!/bin/bash
# -*- coding: utf-8 -*-

FILE=${FILE-scudum.iso}
DEV_NAME=${DEV_NAME-/dev/null}
BOOT_SIZE=${BOOT_SIZE-+1G}
SWAP_SIZE=${SWAP_SIZE-+2G}
NAME=${NAME-scudum}
SCUDUM=${SCUDUM-/tmp/scudum}
TARGET=${TARGET-/mnt/builds/$NAME}
SCHEMA=${SCHEMA-transient}
LOADER=${LOADER-isolinux}
VERSION=${VERSION-latest}
REBUILD=${REBUILD-0}
DEPLOY=${DEPLOY-1}
SQUASH=${SQUASH-1}
AUTORUN=${AUTORUN-1}

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
        SCUDUM=$SCUDUM SCHEMA=$SCHEMA LOADER=$LOADER VERSION=$VERSION $DIR/install.dev.sh
fi

mkdir -pv $SCUDUM
mount -v $DEV_ROOT $SCUDUM
if [ $DEV_ROOT != $DEV_BOOT ]; then
    mkdir -pv $SCUDUM/boot
    mount -v $DEV_BOOT $SCUDUM/boot
fi

SCUDUM=$SCUDUM TARGET=/isolinux $DIR/initrd.sh

cd $SCUDUM
tar -zcf images/root.tar.gz root
tar -zcf images/dev.tar.gz dev
tar -zcf images/etc.tar.gz etc
cd $CUR

if [ "$SQUASH" == "1" ]; then
    ISO_DIR=/tmp/$NAME.iso.dir

    mksquashfs $SCUDUM $NAME.sqfs
    mkdir -pv $ISO_DIR
    cp -rp $SCUDUM/isolinux $ISO_DIR
    mv $NAME.sqfs $ISO_DIR
else
    ISO_DIR=$SCUDUM
fi

if [ "$AUTORUN" == "1" ]; then
    cp $ISO_DIR/isolinux/autorun.inf $ISO_DIR
    cp $ISO_DIR/isolinux/scudum.ico $ISO_DIR
fi

mkisofs -r -J -R -U -joliet -joliet-long -o $FILE\
    -b isolinux/isolinux.bin -c isolinux/boot.cat\
    -no-emul-boot -boot-load-size 4 -boot-info-tabl\
    -V $NAME $ISO_DIR

if [ "$AUTORUN" == "1" ]; then
    rm -v $ISO_DIR/autorun.inf
    rm -v $ISO_DIR/scudum.ico
fi

if [ "$SQUASH" == "1" ]; then
    rm -rf $ISO_DIR
fi

if [ "$DEPLOY" == "1" ]; then
    mv $FILE $TARGET
fi

rm -v $SCUDUM/isolinux/initrd.img
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
