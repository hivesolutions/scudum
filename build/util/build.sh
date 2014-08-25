#!/bin/bash
# -*- coding: utf-8 -*-

DEV_NAME=${DEV_NAME-/dev/sdb}
DEV_BOOT=${DEV_BOOT-"$DEV_NAME"1}
DEV_ROOT=${DEV_ROOT-"$DEV_NAME"3}
SCUDUM=${SCUDUM-/mnt/scudum}
VERSION=${VERSION-0.0.0}
FILE=${FILE-scudum-$VERSION.tar.gz}
SAFE=${SAFE-1}

BASE=$(pwd)

rm -fv $FILE

if [ "$SAFE" == "1" ]; then
    mountpoint $SCUDUM
    if [ "$?" == "0" ]; then
        echo "Target moutpoint $SCUDUM is mounted, skipping build"
        exit 1
    fi
fi

mkdir -pv $SCUDUM
mount -v $DEV_ROOT $SCUDUM
mkdir -pv $SCUDUM/boot
mount -v $DEV_BOOT $SCUDUM/boot

for point in $SCUDUM{/sys,/proc,/dev/pts,/dev}; do
    mountpoint $point
    if [ "$?" != "0" ]; then continue; fi

    sync
    umount -v $point
    if [ "$?" == "0" ]; then continue; fi

    echo "Problem while umounting $point, skipping build"
    exit 1
done

git clone https://github.com/hivesolutions/scudum.git $BASE/scudum.git
find $BASE/scudum.git/system -name "*.sh" -exec rename -v "s/\.sh$//i" {} \;
cp -rpv $BASE/scudum.git/system/* $SCUDUM
rm -rf $BASE/scudum.git

cd $SCUDUM/root
rm -rf .[^.] .??* *

cd $SCUDUM/tmp
rm -rf .[^.] .??* *

cd $SCUDUM/images
rm -rf .[^.] .??* *

rm -rf $SCUDUM/scd/*
rm -rf $SCUDUM/source
rm -rf $SCUDUM/extra
rm -rf $SCUDUM/sources
rm -rf $SCUDUM/extras
rm -rf $SCUDUM/lost+found
rm -rf $SCUDUM/boot/lost+found
rm -f $SCUDUM/boot/initrd.img
rm -f $SCUDUM/isolinux/initrd.img
rm -f $SCUDUM/boot/grub/grub.cfg
rm -f $SCUDUM/etc/fstab
cp -p $SCUDUM/etc/fstab.orig $SCUDUM/etc/fstab
rm -f $SCUDUM/etc/ssh/ssh_host_*

> $SCUDUM/etc/resolv.conf

echo "$VERSION" > $SCUDUM/lib/scudum/VERSION

find $SCUDUM -name "*.pyc" -delete

find $SCUDUM/{,usr/,initrd/}{bin,lib,sbin} -type f -exec strip --strip-debug "{}" ";"

cd $SCUDUM
tar -zcvf $BASE/$FILE *

cd $BASE

sync
umount -v $SCUDUM/boot && rm -rvf $SCUDUM/boot
umount -v $SCUDUM && rm -rvf $SCUDUM
