#!/bin/bash
# -*- coding: utf-8 -*-

DEV_NAME=${DEV_NAME-/dev/null}
DEV_BOOT=${DEV_BOOT-/dev/null}
DEV_SWAP=${DEV_SWAP-/dev/null}
DEV_ROOT=${DEV_ROOT-/dev/null}
BOOT_FS=${BOOT_FS-ext2}
ROOT_FS=${ROOT_FS-ext3}
SCHEMA=${SCHEMA-stored}
LOADER=${LOADER-grub}
SCUDUM=${SCUDUM-/tmp/scudum}
NAME=${NAME-scudum}
VERSION=${VERSION-latest}
REPO=${REPO-http://hole1.hive:9090/builds/scudum}

if [ $DEV_ROOT == $DEV_BOOT ]; then BOOT_FS=$ROOT_FS; fi

if [ $DEV_BOOT != /dev/null ]; then mkfs.$BOOT_FS $DEV_BOOT; fi
if [ $DEV_ROOT != /dev/null ]; then mkfs.$ROOT_FS $DEV_ROOT; fi
if [ $DEV_SWAP != /dev/null ]; then mkswap $DEV_SWAP; fi

eval $(blkid -o export $DEV_BOOT)
BOOT_UUID=$UUID
eval $(blkid -o export $DEV_ROOT)
ROOT_UUID=$UUID
eval $(blkid -o export $DEV_SWAP)
SWAP_UUID=$UUID

mkdir -pv $SCUDUM
mount -v $DEV_ROOT $SCUDUM
if [ $DEV_ROOT != $DEV_BOOT ]; then
    mkdir -pv $SCUDUM/boot
    mount -v $DEV_BOOT $SCUDUM/boot
fi

rm -rf $SCUDUM/lost+found
rm -rf $SCUDUM/boot/lost+found

cd $SCUDUM

wget "$REPO/$NAME-$VERSION.tar.gz"
tar -zxf $NAME-$VERSION.tar.gz
rm -v $NAME-$VERSION.tar.gz

cp -p $SCUDUM/etc/fstab.orig $SCUDUM/etc/fstab

mount -v --bind /dev $SCUDUM/dev
mount -vt devpts devpts $SCUDUM/dev/pts
mount -vt proc proc $SCUDUM/proc
mount -vt sysfs sysfs $SCUDUM/sys

case $SCHEMA in
    stored)
        echo "UUID=$ROOT_UUID / $ROOT_FS defaults,noatime 0 1" >> $SCUDUM/etc/fstab
        echo "UUID=$SWAP_UUID none swap pri=1 0 0" >> $SCUDUM/etc/fstab
        if [ $DEV_ROOT != $DEV_BOOT ]; then
            echo "UUID=$BOOT_UUID /boot $BOOT_FS noauto,noatime 1 2" >> $SCUDUM/etc/fstab
        fi
        ;;

    transient)
        echo "tmpfs / tmpfs defaults 0 0" >> $SCUDUM/etc/fstab
        ;;
esac

case $LOADER in
    grub)
        cat $SCUDUM/boot/grub/grub.cfg.tpl | sed -e "s/\${BOOT_FS}/$BOOT_FS/"\
            -e "s/\${ROOT_UUID}/$ROOT_UUID/" > $SCUDUM/boot/grub/grub.cfg

        grub-install --root-directory=$SCUDUM/boot/grub $DEV_NAME && sync
        ;;

    extlinux|isolinux)
        dd if=/usr/lib/syslinux/mbr.bin conv=notrunc\
            bs=440 count=1 of=$DEV_NAME
        extlinux --heads=255 --sectors=63 --install $SCUDUM/boot && sync
        ;;
esac

cd /

sync
umount -v $SCUDUM/sys
umount -v $SCUDUM/proc
umount -v $SCUDUM/dev/pts
umount -v $SCUDUM/dev

if [ $DEV_ROOT != $DEV_BOOT ]; then
    umount -v $SCUDUM/boot && rm -rvf $SCUDUM/boot
fi
umount -v $SCUDUM && rm -rvf $SCUDUM
