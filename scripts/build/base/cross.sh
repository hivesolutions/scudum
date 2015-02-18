#!/bin/bash
# -*- coding: utf-8 -*-

set -e +h

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

if [ "$SCUDUM_CROSS_COPY" == "1" ]; then
    cp -rpn /opt/$ARCH_TARGET/* $SCUDUM/cross
else
    $DIR/../cross/binutils.sh
    $DIR/../cross/$GCC_BUILD_BINARY.pass1.sh
    $DIR/../cross/linux-headers.sh
    $DIR/../cross/glibc.sh
    $DIR/../cross/libstdc++.sh
    $DIR/../cross/$GCC_BUILD_BINARY.pass2.sh
fi
