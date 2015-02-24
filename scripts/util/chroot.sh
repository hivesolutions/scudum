#!/bin/bash
# -*- coding: utf-8 -*-

PERSIST=${PERSIST-/pst}
SCUDUM=${SCUDUM-/scudum}
CHROOT_ARGS=${CHROOT_ARGS---login +h}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

if mountpoint -q $PERSIST; then
    SCUDUM=$PERSIST/scudum
fi

if [ -e $SCUDUM/config ]; then
    source $SCUDUM/config
fi

mount -v --bind /dev $SCUDUM/dev
mount -vt devpts devpts $SCUDUM/dev/pts -o gid=5,mode=620
mount -vt proc proc $SCUDUM/proc
mount -vt sysfs sysfs $SCUDUM/sys

trap "SCUDUM=$SCUDUM $DIR/release.sh" SIGINT SIGTERM

mkdir -pv $SCUDUM/etc
rm -f $SCUDUM/etc/resolv.conf
echo "nameserver 8.8.8.8" >> $SCUDUM/etc/resolv.conf

if [ "$SCUDUM_CROSS" == "1" ]; then
    TARGET_PATH=/cross/bin:/tools/bin:/bin:/usr/bin:/sbin:/usr/sbin
    TARGET_SHELL=/tools/bin/bash
    TARGET_ENV=/tools/bin/env
else
    TARGET_PATH=/bin:/usr/bin:/sbin:/usr/sbin
    TARGET_SHELL=/bin/bash
    TARGET_ENV=/usr/bin/env
fi

chroot $SCUDUM $TARGET_ENV -i\
    HOME=/root TERM="$TERM" PS1="\u:\w\$ "\
    PATH="$TARGET_PATH"\
    $TARGET_SHELL $CHROOT_ARGS $@
result=$?

chroot $SCUDUM $TARGET_ENV -i\
    HOME=/root TERM="$TERM" PS1="\u:\w\$ "\
    PATH="$TARGET_PATH"\
    $TARGET_SHELL -c "/bin/umount -v -a"

SCUDUM=$SCUDUM $DIR/release.sh

exit $result
