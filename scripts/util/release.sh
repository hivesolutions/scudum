#!/bin/bash
# -*- coding: utf-8 -*-

SCUDUM=${SCUDUM-/scudum}

sync

umount -v $SCUDUM/sys
umount -v $SCUDUM/proc
umount -v $SCUDUM/dev/pts
umount -v $SCUDUM/dev
