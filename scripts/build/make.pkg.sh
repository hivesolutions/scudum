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

CUR=$(pwd)
DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/base/config.sh

DISTRIB=${DISTRIB-$(cat $SCUDUM/etc/scudum/DISTRIB)}
FILE=${FILE-$NAME-$VERSION.tar.gz}

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

tar -zcvf $FILE $SCUDUM

if [ "$DEPLOY" == "1" ]; then
    mkdir -pv $TARGET && mv -v $FILE $TARGET
fi
