#!/bin/bash
# -*- coding: utf-8 -*-

MAJOR=${MAJOR-3.x}
MINOR=${MINOR-3.12.6}
BUILD=${BUILD-1}
NAME=linux-$MINOR

mkdir -p /sources
cd /sources

if [ ! -d "linux-$MINOR" ]; then
    wget https://www.kernel.org/pub/linux/kernel/v$MAJOR/$NAME.tar.xz
    tar -xvf $NAME.tar.xz
else
    echo "Skipping $NAME retrieval, already exists ..."
fi

cd $NAME
cp /boot/config .config

if [ "$BUILD" != "1" ]; then
    exit 0
fi

make

cp -v arch/x86/boot/bzImage /boot/vmlinuz
cp -v arch/x86/boot/bzImage /isolinux/vmlinuz

cp -v .config /boot/config
