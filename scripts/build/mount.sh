#!/bin/bash
# -*- coding: utf-8 -*-

ORIGIN=${ORIGIN-//files.hive/builds}
TARGET=${TARGET-/mnt/builds}
USERNAME=${USERNAME-anonymous}
PASSWORD=${PASSWORD-anonymous}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/base/config.sh

if mountpoint -q $TARGET; then
    unmount $TARGET
fi

mkdir -p $TARGET && mount -t cifs -o username=$USERNAME,password=$PASSWORD $ORIGIN $TARGET
