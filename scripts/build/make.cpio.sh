#!/bin/bash
# -*- coding: utf-8 -*-

NAME=${NAME-scudum}
BASE=${BASE-/mnt/builds}
TARGET=${TARGET-$BASE/$NAME/cpio}
SCHEMA=${SCHEMA-transient}
KVARIANT=${KVARIANT-basic}
CONFIG=${CONFIG-1}
CLEANUP=${CLEANUP-1}
DEPLOY=${DEPLOY-0}
SQUASH=${SQUASH-1}

CUR=$(pwd)
DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/base/config.sh

DISTRIB=${DISTRIB-$(cat $SCUDUM/etc/scudum/DISTRIB)}

if [ "$DISTRIB" == "generic" ]; then
    FILE=${FILE-$NAME-$VERSION.cpio.gz}
    FILE_LATEST=${FILE_LATEST-$NAME-latest.cpio.gz}
else
    FILE=${FILE-$NAME-$DISTRIB-$VERSION.cpio.gz}
    FILE_LATEST=${FILE_LATEST-$NAME-$DISTRIB-latest.cpio.gz}
fi

if type apt-get &> /dev/null; then
    apt-get -y install squashfs-tools
elif type scu &> /dev/null; then
    env -u VERSION scu install squashfs-tools
else
    exit 1
fi

if [ "$CONFIG" == "1" ]; then
    SCHEMA=$SCHEMA KVARIANT=$KVARIANT $DIR/config.sh
fi

if [ ! -e $SCUDUM/etc/scudum/CONFIGURED ]; then
    echo "make.cpio: scudum not configured, not possible to make CPIO"
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
    CPIO_DIR=/tmp/$NAME.iso.dir
    mksquashfs $(readlink -f $SCUDUM) $NAME.sqfs
    mkdir -pv $CPIO_DIR
    cp -rp $SCUDUM/boot $CPIO_DIR
    cp -rp $SCUDUM/isolinux $CPIO_DIR
    cp -rp $SCUDUM/usr/share/mkinitramfs/linuxrc $CPIO_DIR
    mv -v $NAME.sqfs $CPIO_DIR
else
    CPIO_DIR=$SCUDUM
fi

find $CPIO_DIR -depth -print | cpio -ocvB | gzip -c > $FILE

if [ "$DEPLOY" == "1" ]; then
    mkdir -pv $TARGET && mv -v $FILE $TARGET
    ln -svf $FILE $TARGET/$FILE_LATEST
fi
