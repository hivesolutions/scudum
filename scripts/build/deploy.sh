#!/bin/bash
# -*- coding: utf-8 -*-

NAME=${NAME-scudum}
VERSION=${VERSION-$(date +%Y%m%d)}
TARGET=${TARGET-/mnt/builds/$NAME}

LATEST=$NAME-latest.tar.gz
DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/base/config.sh

if [ -e $SCUDUM/config ]; then
    source $SCUDUM/config
fi

if [ "$SCUDUM_ARCH" == "" ]; then
    FILE=${FILE-$NAME-$VERSION.tar.gz}
else
    FILE=${FILE-$NAME-$VERSION-$SCUDUM_ARCH.tar.gz}
fi

NAME=$NAME VERSION=$VERSION FILE=$FILE $DIR/pack.sh

mkdir -pv $TARGET
mv -fv $FILE $TARGET

cd $TARGET
rm -fv $LATEST
ln -sv $FILE $LATEST
