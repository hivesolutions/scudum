#!/bin/bash
# -*- coding: utf-8 -*-

NAME=${NAME-scudum}
VERSION=${VERSION-$(date +%Y%m%d)}
FILE=${FILE-$NAME-$VERSION.tar.gz}
TARGET=${TARGET-/mnt/builds/$NAME}

LATEST=$NAME-latest.tar.gz
DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/base/config.sh

NAME=$NAME VERSION=$VERSION FILE=$FILE $DIR/pack.sh

mkdir -pv $TARGET
mv -fv $FILE $TARGET

cd $TARGET
rm -fv $LATEST
ln -sv $FILE $LATEST
