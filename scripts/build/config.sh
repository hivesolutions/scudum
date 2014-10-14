#!/bin/bash
# -*- coding: utf-8 -*-

DEV_NAME=${DEV_NAME-/dev/null}
DEV_BOOT=${DEV_BOOT-/dev/null}
DEV_SWAP=${DEV_SWAP-/dev/null}
DEV_ROOT=${DEV_ROOT-/dev/null}
SCHEMA=${SCHEMA-transient}
BCERT=${BCERT-1}
BEXTRAS=${BEXTRAS-1}
BACCOUNT=${BACCOUNT-1}
BKERNEL=${BKERNEL-1}
BINIT=${BINIT-1}
BRAMFS=${BRAMFS-1}
CHROOT_ARGS=${CHROOT_ARGS-+h}

BASE=$(pwd)
DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))
CHROOT=$DIR/../util/chroot.sh

set -e +h

source $DIR/base/config.sh

if [ ! -e $SCUDUM ]; then
    echo "config: scudum is not installed, not possible to configure"
    exit 1
fi

if [ -e $SCUDUM/etc/scudum/CONFIGURED ]; then
    echo "config: scudum already configured, may create duplicated files"
fi

git clone --depth 1 https://github.com/hivesolutions/scudum.git $BASE/scudum.git
cp -rpv $BASE/scudum.git/system/* $SCUDUM
rm -rf $BASE/scudum.git

mkdir -p $SCUDUM/etc/scudum
touch $SCUDUM/etc/scudum/VERSION
touch $SCUDUM/etc/scudum/DISTRIB
touch $SCUDUM/etc/scudum/CONFIGURED

echo $VERSION > $SCUDUM/etc/scudum/VERSION
echo $DISTRIB > $SCUDUM/etc/scudum/DISTRIB
echo $EXTRAS > $SCUDUM/etc/scudum/CONFIGURED

if [ -e boot ]; then
    cp -p boot $SCUDUM/etc/boot/$DISTRIB
fi

if [ -e welcome ]; then
    cp -p welcome $SCUDUM/etc/welcome/$DISTRIB
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

test $BCERT == "1" && CHROOT_ARGS=$CHROOT_ARGS $CHROOT /bin/cert.build || true
test $BEXTRAS == "1" && CHROOT_ARGS=$CHROOT_ARGS $CHROOT bin/scu.build || true
test $BACCOUNT == "1" && CHROOT_ARGS=$CHROOT_ARGS $CHROOT /bin/account.build || true
test $BKERNEL == "1" && CHROOT_ARGS=$CHROOT_ARGS $CHROOT /bin/kernel.install || true
test $BINIT == "1" && CHROOT_ARGS=$CHROOT_ARGS $CHROOT /bin/init.build || true
test $BRAMFS == "1" && CHROOT_ARGS=$CHROOT_ARGS $CHROOT /sbin/mkinitramfs || true
