#!/bin/bash
# -*- coding: utf-8 -*-

set -e +h

apt-get update

scudum root && scudum deploy

SCUDUM_ARCH=arm6 SCUDUM_VENDOR=rasp SCUDUM_SYSTEM=linux-gnueabihf \
GCC_BUILD_ARCH=armv6zk GCC_BUILD_TUNE=arm1176jzf-s GCC_BUILD_FPU=vfp \
GCC_BUILD_FLOAT=hard scudum root && scudum deploy

SCUDUM_ARCH=arm7 SCUDUM_VENDOR=rasp SCUDUM_SYSTEM=linux-gnueabihf \
GCC_BUILD_ARCH=armv7-a GCC_BUILD_TUNE=cortex-a7 GCC_BUILD_FPU=neon-vfpv4 \
GCC_BUILD_FLOAT=hard scudum root && scudum deploy
