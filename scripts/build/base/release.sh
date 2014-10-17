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

mountpoint -q $SCUDUM/dev/shm && umount -v $FLAGS $SCUDUM/dev/shm

umount -v $FLAGS $SCUDUM/sys
umount -v $FLAGS $SCUDUM/proc
umount -v $FLAGS $SCUDUM/dev/pts
umount -v $FLAGS $SCUDUM/dev
