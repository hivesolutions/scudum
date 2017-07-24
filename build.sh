#!/bin/bash
# -*- coding: utf-8 -*-

LINUX_X64=${LINUX_X64-1}
RASP_ARM6=${RASP_ARM6-1}
RASP_ARM7=${RASP_ARM7-1}

set -e +h

apt-get update

if [ "$LINUX_X64" == "1" ]; then
    GCC_FLAVOUR=latest scudum root && scudum deploy
fi

if [ "$RASP_ARM6" == "1" ]; then
    SCUDUM_ARCH=arm6 SCUDUM_VENDOR=rasp SCUDUM_SYSTEM=linux-gnueabihf \
    GCC_BUILD_ARCH=armv6zk GCC_BUILD_TUNE=arm1176jzf-s GCC_BUILD_FPU=vfp \
    GCC_BUILD_FLOAT=hard GCC_FLAVOUR=latest scudum root && scudum deploy
fi

if [ "$RASP_ARM7" == "1" ]; then
    SCUDUM_ARCH=arm7 SCUDUM_VENDOR=rasp SCUDUM_SYSTEM=linux-gnueabihf \
    GCC_BUILD_ARCH=armv7-a GCC_BUILD_TUNE=cortex-a7 GCC_BUILD_FPU=neon-vfpv4 \
    GCC_BUILD_FLOAT=hard GCC_FLAVOUR=latest scudum root && scudum deploy
fi
