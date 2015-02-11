#!/bin/bash
# -*- coding: utf-8 -*-

NAME=${NAME-scudum}
BASE=${BASE-/mnt/builds}
TARGET=${TARGET-$BASE/$NAME/pkg}
SCHEMA=${SCHEMA-transient}
KVARIANT=${KVARIANT-default}
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
    FILE=${FILE-$NAME-$VERSION}
    FILE_LATEST=${FILE-$NAME-latest}
else
    FILE=${FILE-$NAME-$DISTRIB-$VERSION}
    FILE_LATEST=${FILE-$NAME-$DISTRIB-latest}
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
    echo "make.iso: scudum not configured, not possible to make PKG"
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

PKG_DIR=$CUR/$FILE
mkdir -pv $PKG_DIR

if [ "$SQUASH" == "1" ]; then
    mksquashfs $(readlink -f $SCUDUM) $NAME.sqfs
    cp -rp $SCUDUM/boot $PKG_DIR
    mv -v $NAME.sqfs $PKG_DIR
else
    cp -rp $SCUDUM/* $PKG_DIR
fi

if [ "$SQUASH" == "1" ]; then
    rm -rf $ISO_DIR
fi

if [ "$DEPLOY" == "1" ]; then
    rm -rf $TARGET/$FILE
    mkdir -pv $TARGET && mv -v $PKG_DIR $TARGET
    ln -svf $FILE $TARGET/$FILE_LATEST
fi

rm -rv $SCUDUM/images
