#!/bin/bash
# -*- coding: utf-8 -*-

NAME=${NAME-scudum}
VERSION=${VERSION-$(date +%Y%m%d)}
TARGET=${TARGET-/mnt/builds/$NAME}

LATEST=$NAME-latest.tar.gz
DIR=$(dirname $(readlink -f $0))

set -e

source $DIR/base/config.sh

NAME=$NAME VERSION=$VERSION FILE=$FILE $DIR/pack.sh

mv -fv $FILE $TARGET

cd $TARGET
rm -fv $LATEST
ln -s $FILE $LATEST
