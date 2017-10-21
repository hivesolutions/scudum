#!/bin/bash
# -*- coding: utf-8 -*-

ORIGIN=${ORIGIN-//files.hive/builds}
TARGET=${TARGET-/mnt/builds}
USERNAME=${USERNAME-bot}
PASSWORD=${PASSWORD-anonymous}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/base/config.sh

if mountpoint -q $TARGET; then
    umount $TARGET
fi

mkdir -p $TARGET && mount -t cifs -o vers=1.0,username=$USERNAME,password=$PASSWORD $ORIGIN $TARGET
