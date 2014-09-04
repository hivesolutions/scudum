#!/bin/bash
# -*- coding: utf-8 -*-

NAME=${NAME-scudum}
VERSION=${VERSION-$(date +%Y%m%d)}
LABEL=${LABEL-Scudum}
BASE=${BASE-/mnt/builds}
TARGET=${TARGET-$BASE/$NAME/iso}
LOADER=${LOADER-isolinux}
SCHEMA=${SCHEMA-transient}
CONFIG=${CONFIG-1}
CLEANUP=${CLEANUP-1}
DEPLOY=${DEPLOY-0}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/base/config.sh

DISTRIB=${DISTRIB-$(cat $SCUDUM/etc/scudum/DISTRIB)}

if [ "$DISTRIB" == "generic" ]; then
    FILE=${FILE-$NAME-$VERSION}
else
    FILE=${FILE-$NAME-$DISTRIB-$VERSION}
fi

apt-get -y install lxc-docker

if [ "$CONFIG" == "1" ]; then
    SCHEMA=$SCHEMA $DIR/config.sh
fi

if [ ! -e $SCUDUM/etc/scudum/CONFIGURED ]; then
    echo "Scudum not configured, not possible to make ISO"
    exit 1
fi

if [ "$CLEANUP" == "1" ]; then
    $DIR/cleanup.sh
fi

tar -C $SCUDUM -c . | docker import - $FILE

if [ "$DEPLOY" == "1" ]; then
    mv $FILE $TARGET
fi

rm -rv $SCUDUM/images
