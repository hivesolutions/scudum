#!/bin/bash
# -*- coding: utf-8 -*-

NAME=${NAME-scudum}
VERSION=${VERSION-$(date +%Y%m%d)}
LABEL=${LABEL-Scudum}
BASE=${BASE-/mnt/builds}
TARGET=${TARGET-$BASE/$NAME/iso}
SCHEMA=${SCHEMA-transient}
BASIC=${BASIC-1}
CONFIG=${CONFIG-1}
CLEANUP=${CLEANUP-1}
DEPLOY=${DEPLOY-0}
SQUASH=${SQUASH-1}
AUTORUN=${AUTORUN-1}

CUR=$(pwd)
DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/base/config.sh

DISTRIB=${DISTRIB-$(cat $SCUDUM/etc/scudum/DISTRIB)}

if [ "$DISTRIB" == "generic" ]; then
    FILE=${FILE-$NAME-$VERSION.iso}
    FILE_BASIC=${FILE_BASIC-$NAME-$VERSION.basic.iso}
else
    FILE=${FILE-$NAME-$DISTRIB-$VERSION.iso}
    FILE_BASIC=${FILE_BASIC-$NAME-$DISTRIB-$VERSION.basic.iso}
fi

if type apt-get &> /dev/null; then
    apt-get -y install genisoimage squashfs-tools
elif type scu &> /dev/null; then
    scu install cdrtools squashfs-tools
else
    exit 1
fi

if [ "$CONFIG" == "1" ]; then
    SCHEMA=$SCHEMA $DIR/config.sh
fi

if [ ! -e $SCUDUM/etc/scudum/CONFIGURED ]; then
    echo "make.iso: scudum not configured, not possible to make ISO"
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
    ISO_DIR=/tmp/$NAME.iso.dir
    mksquashfs $SCUDUM data.sqfs
    mkdir -pv $ISO_DIR
    cp -rp $SCUDUM/isolinux $ISO_DIR
    mv -v data.sqfs $ISO_DIR
else
    ISO_DIR=$SCUDUM
fi

if [ "$AUTORUN" == "1" ]; then
    cp -v $SCUDUM/isolinux/autorun.inf $ISO_DIR
    cp -v $SCUDUM/isolinux/scudum.ico $ISO_DIR
fi

mkisofs -r -J -R -U -joliet -joliet-long -o $FILE\
    -b isolinux/isolinux.bin -c isolinux/boot.cat\
    -no-emul-boot -boot-load-size 4 -boot-info-table\
    -V $LABEL $ISO_DIR

if [ "$BASIC" == "1" ]; then
    mkisofs -o $FILE_BASIC\
        -b isolinux/isolinux.bin -c isolinux/boot.cat\
        -no-emul-boot -boot-load-size 4 -boot-info-table\
        -V $LABEL $ISO_DIR
fi

if [ "$AUTORUN" == "1" ]; then
    rm -v $ISO_DIR/autorun.inf
    rm -v $ISO_DIR/scudum.ico
fi

if [ "$SQUASH" == "1" ]; then
    rm -rf $ISO_DIR
fi

if [ "$DEPLOY" == "1" ]; then
    mkdir -pv $TARGET && mv -v $FILE $TARGET
    if [ "$BASIC" == "1" ]; then mv -v $FILE_BASIC $TARGET; fi
fi

rm -rv $SCUDUM/images
