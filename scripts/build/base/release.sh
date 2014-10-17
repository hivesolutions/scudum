#!/bin/bash
# -*- coding: utf-8 -*-

SCUDUM=${SCUDUM-/scudum}

sync

mountpoint -q $SCUDUM/dev/shm && umount -v $SCUDUM/dev/shm

umount -v $SCUDUM/sys
umount -v $SCUDUM/proc
umount -v $SCUDUM/dev/pts
umount -v $SCUDUM/dev
