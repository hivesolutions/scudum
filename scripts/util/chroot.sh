#!/bin/bash
# -*- coding: utf-8 -*-

PERSIST=${PERSIST-/pst}
SCUDUM=${SCUDUM-/scudum}
CHROOT_ARGS=${CHROOT_ARGS---login +h}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

if mountpoint -q $PERSIST; then
    SCUDUM=$PERSIST/scudum
fi

mount -v --bind /dev $SCUDUM/dev
mount -vt devpts devpts $SCUDUM/dev/pts -o gid=5,mode=620
mount -vt proc proc $SCUDUM/proc
mount -vt sysfs sysfs $SCUDUM/sys

trap "SCUDUM=$SCUDUM $DIR/release.sh" SIGINT SIGTERM

mkdir -pv $SCUDUM/etc
rm -f $SCUDUM/etc/resolv.conf
echo "nameserver 8.8.8.8" >> $SCUDUM/etc/resolv.conf

chroot $SCUDUM /usr/bin/env -i\
    HOME=/root TERM="$TERM" PS1='\u:\w\$ '\
    PATH=/bin:/usr/bin:/sbin:/usr/sbin\
    /bin/bash $CHROOT_ARGS $@
result=$?

chroot $SCUDUM /usr/bin/env -i\
    HOME=/root TERM="$TERM" PS1='\u:\w\$ '\
    PATH=/bin:/usr/bin:/sbin:/usr/sbin\
    /bin/bash $CHROOT_ARGS -c "/bin/umount -v -a"

SCUDUM=$SCUDUM $DIR/release.sh

exit $result
