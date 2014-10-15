#!/bin/bash
# -*- coding: utf-8 -*-

ORIGIN=${ORIGIN-//files.hive/builds}
TARGET=${TARGET-/mnt/builds}
USERNAME=${USERNAME-anonymous}
PASSWORD=${PASSWORD-anonymous}

set -e +h

source $DIR/base/config.sh

mkdir -p $TARGET && mount -t cifs -o username=$USERNAME,password=$PASSWORD $ORIGIN $TARGET
