#!/bin/bash
# -*- coding: utf-8 -*-

DEV_NAME=${DEV_NAME-/dev/null}
DEV_BOOT=${DEV_BOOT-/dev/null}
DEV_SWAP=${DEV_SWAP-/dev/null}
DEV_ROOT=${DEV_ROOT-/dev/null}
SCHEMA=${SCHEMA-transient}

BASE=$(pwd)
DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/base/config.sh

if [ -e $SCUDUM/etc/scudum/CONFIGURED ]; then
    echo "Scudum already configured, may create duplicated files"
fi

mkdir -p $SCUDUM/etc/scudum
touch $SCUDUM/etc/scudum/DISTRIB
touch $SCUDUM/etc/scudum/CONFIGURED

echo $DISTRIB > $SCUDUM/etc/scudum/DISTRIB
echo $EXTRAS > $SCUDUM/etc/scudum/CONFIGURED

git clone --depth 1 https://github.com/hivesolutions/scudum.git $BASE/scudum.git
cp -rpv $BASE/scudum.git/system/* $SCUDUM
rm -rf $BASE/scudum.git

if [ -e boot ]; then
    cp -p boot $SCUDUM/etc/boot/$DISTRIB
fi

if [ -e system ]; then
    cp -rpv system/* $SCUDUM
fi

cp -p $SCUDUM/etc/fstab.orig $SCUDUM/etc/fstab

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

$DIR/../util/chroot.sh /bin/cert.build
$DIR/../util/chroot.sh /bin/extras.build
$DIR/../util/chroot.sh /bin/account.build
$DIR/../util/chroot.sh /bin/kernel.build
$DIR/../util/chroot.sh /bin/init.build
$DIR/../util/chroot.sh /sbin/mkinitramfs
