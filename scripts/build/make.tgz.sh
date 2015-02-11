#!/bin/bash
# -*- coding: utf-8 -*-

NAME=${NAME-scudum}
BASE=${BASE-/mnt/builds}
TARGET=${TARGET-$BASE/$NAME/tgz}
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

if [ "$DISTRIB" == "generic" ]; then
    FILE=${FILE-$NAME-$VERSION.tar.gz}
else
    FILE=${FILE-$NAME-$DISTRIB-$VERSION.tar.gz}
fi

if [ "$CONFIG" == "1" ]; then
    SCHEMA=$SCHEMA KVARIANT=$KVARIANT $DIR/config.sh
fi

if [ ! -e $SCUDUM/etc/scudum/CONFIGURED ]; then
    echo "make.iso: scudum not configured, not possible to make TGZ"
    exit 1
fi

if [ "$CLEANUP" == "1" ]; then
    $DIR/cleanup.sh
fi

cd $SCUDUM

tar -zcvf $CUR/$FILE *

cd $CUR

if [ "$DEPLOY" == "1" ]; then
    mkdir -pv $TARGET && mv -v $FILE $TARGET
fi
