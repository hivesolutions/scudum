#!/bin/bash
# -*- coding: utf-8 -*-

TARGET=${TARGET-/mnt/builds}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/base/config.sh

if mountpoint -q $TARGET; then
    umount $TARGET
fi
