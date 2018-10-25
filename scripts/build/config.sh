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
BINITRD=${BINITRD-1}
CHROOT_ARGS=${CHROOT_ARGS---login +h}

BASE=$(pwd)
DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))
CHROOT=$DIR/../util/chroot.sh

set -e +h

source $DIR/base/config.sh

if [ -e $SCUDUM/config ]; then
    source $SCUDUM/config
fi

case "$SCUDUM_ARCH" in
    arm*)
        KVARIANT=${KVARIANT-rasp}
        ;;
    *)
        KVARIANT=${KVARIANT-basic}
        ;;
esac

if [ ! -e $SCUDUM ]; then
    echo "config: scudum is not installed, not possible to configure"
    exit 1
fi

if [ -e $SCUDUM/etc/scudum/CONFIGURED ]; then
    echo "config: scudum already configured, may create duplicated files"

    PREVIOUS=$(cat $SCUDUM/etc/scudum/DISTRIB)

    if [ "$PREVIOUS" != "$DISTRIB" ]; then
        echo "config: '$PREVIOUS' configuration cannot be changed to '$DISTRIB'"
        exit 1
    fi
fi

# clones the current scudum distribution to obtain the latest
# version of its scripts that are going to be included with this builf
git clone --depth 1 "https://github.com/hivesolutions/scudum.git" $BASE/scudum.git
cp -rpv $BASE/scudum.git/system/* $SCUDUM
rm -rf $BASE/scudum.git

if [ -e system ]; then
    cp -rpv system/* $SCUDUM
fi

if [ -e boot ] && [ -f boot ]; then
    cp -p boot $SCUDUM/etc/boot/$DISTRIB
fi

if [ -e halt ] && [ -f halt ]; then
    cp -p halt $SCUDUM/etc/halt/$DISTRIB
fi

if [ -e welcome ] && [ -f welcome ]; then
    cp -p welcome $SCUDUM/etc/welcome/$DISTRIB
fi

# creates the scudum specific files that contain
# a series of snapshot information on this build
echo $VERSION > $SCUDUM/etc/scudum/VERSION
echo $SCUDUM_DATE > $SCUDUM/etc/scudum/ROOTFS
echo $DISTRIB > $SCUDUM/etc/scudum/DISTRIB
echo $EXTRAS > $SCUDUM/etc/scudum/CONFIGURED

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

if [ $BCERT == "1" ]; then CHROOT_ARGS=$CHROOT_ARGS $CHROOT /bin/cert.build; fi
if [ $BEXTRAS == "1" ]; then CHROOT_ARGS=$CHROOT_ARGS $CHROOT bin/scu.build; fi
if [ $BACCOUNT == "1" ]; then CHROOT_ARGS=$CHROOT_ARGS $CHROOT /bin/account.build; fi
if [ $BKERNEL == "1" ]; then CHROOT_ARGS=$CHROOT_ARGS $CHROOT /bin/kernel.install $KVARIANT; fi
if [ $BKERNEL == "1" ] && [ "$KVARIANT" == "rasp" ]; then CHROOT_ARGS=$CHROOT_ARGS $CHROOT /bin/kernel.install "$KVARIANT"2 vmlinuz7; fi
if [ $BINIT == "1" ]; then CHROOT_ARGS=$CHROOT_ARGS $CHROOT /bin/init.build; fi
if [ $BINITRD == "1" ]; then CHROOT_ARGS=$CHROOT_ARGS $CHROOT /bin/initrd.build; fi
