#!/bin/bash
# -*- coding: utf-8 -*-

DEV_NAME=${DEV_NAME-/dev/null}
FILE=${FILE-scudum.img}
BUFFER=${BUFFER-1M}

dd bs=$BUFFER if=$FILE of=$DEV_NAME
