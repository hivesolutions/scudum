#!/bin/bash
# -*- coding: utf-8 -*-

MAJOR=${MAJOR-3.x}
MINOR=${MINOR-3.12.6}
BUILD=${BUILD-1}

mkdir -p /sources
cd /sources

if [ ! -d "linux-$MINOR" ];
    wget https://www.kernel.org/pub/linux/kernel/v$MAJOR/linux-$MINOR.tar.xz
    tar -xvf linux-$MINOR.tar.xz
fi

cd linux-$MINOR
cp /boot/config .config

if [ "$BUILD" != "1" ]; then
    exit 0
fi

make
cp arch/x86/boot/bzImage /boot/vmlinuz
cp arch/x86/boot/bzImage /isolinux/vmlinuz
