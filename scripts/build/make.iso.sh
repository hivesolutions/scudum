#!/bin/bash
# -*- coding: utf-8 -*-

NAME=${NAME-scudum}
VERSION=${VERSION-$(date +%Y%m%d)}
FILE=${FILE-$NAME-$VERSION.iso}
LABEL=${NAME-Scudum Linux}
SCUDUM=${SCUDUM-/scudum}
TARGET=${TARGET-/mnt/builds/$NAME}
LOADER=${LOADER-isolinux}
DEPLOY=${DEPLOY-1}
SQUASH=${SQUASH-1}
AUTORUN=${AUTORUN-1}

set -e

apt-get -y install squashfs-tools

if [ ! -e $SCUDUM/CONFIGURED ]; then
    echo "Scudum not configured, not possible to make ISO"
    exit 1
fi

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
    -V $LABEL $ISO_DIR

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
