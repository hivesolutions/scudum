#!/bin/bash
# -*- coding: utf-8 -*-

DEV_NAME=${DEV_NAME-/dev/sdb}
DEV_BOOT=${DEV_BOOT-"$DEV_NAME"1}
DEV_ROOT=${DEV_ROOT-"$DEV_NAME"3}
NAME=${NAME-scudum}
VERSION=${VERSION-0.0.0}
FILE=${FILE-$NAME-$VERSION.tar.gz}
TARGET=${TARGET-/mnt/builds/$NAME}

LATEST=$NAME-latest.tar.gz
DIR=$(dirname $(readlink -f $0))

DEV_NAME=$DEV_NAME DEV_BOOT=$DEV_BOOT DEV_SWAP=$DEV_SWAP\
    FILE=$FILE $DIR/build.sh

mv -fv $FILE $TARGET

cd $TARGET
rm -fv $LATEST
ln -s $FILE $LATEST
