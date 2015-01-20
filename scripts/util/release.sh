#!/bin/bash
# -*- coding: utf-8 -*-

SCUDUM=${SCUDUM-/scudum}
MTAB=${MTAB-1}

if [ "$MTAB" == "1" ]; then
    FLAGS=""
else
    FLAGS="-n"
fi

sync

mountpoint -q $SCUDUM/mnt/builds && umount -v $FLAGS $SCUDUM/mnt/builds
mountpoint -q $SCUDUM/sys && umount -v $FLAGS $SCUDUM/sys
mountpoint -q $SCUDUM/proc && umount -v $FLAGS $SCUDUM/proc
mountpoint -q $SCUDUM/dev/pts && umount -v $FLAGS $SCUDUM/dev/pts
mountpoint -q $SCUDUM/dev && umount -v $FLAGS $SCUDUM/dev
