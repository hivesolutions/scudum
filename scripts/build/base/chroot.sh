set -e

mkdir -pv $SCUDUM/{dev,proc,sys}

# crates the main device nodes with the proper
# flags set for the devices (going to be re-used)
test ! -e $SCUDUM/dev/console &&\
    mknod -m 600 $SCUDUM/dev/console c 5 1
test ! -e $SCUDUM/dev/null &&\
    mknod -m 666 $SCUDUM/dev/null c 1 3

# verifies each of the special filesystems for
# mounting and in case they are mounted umounts
# them avoiding a duplicate re-mounting
mountpoint -q $SCUDUM/sys && umount $SCUDUM/sys
mountpoint -q $SCUDUM/proc && umount $SCUDUM/proc
mountpoint -q $SCUDUM/dev/pts && umount $SCUDUM/dev/pts
mountpoint -q $SCUDUM/dev && umount $SCUDUM/dev

mount -v --bind /dev $SCUDUM/dev

mount -vt devpts devpts $SCUDUM/dev/pts
mount -vt proc proc $SCUDUM/proc
mount -vt sysfs sysfs $SCUDUM/sys

mkdir -pv $SCUDUM/etc
rm -f $SCUDUM/etc/resolv.conf
echo "nameserver 8.8.8.8" >> $SCUDUM/etc/resolv.conf

if [ -h $SCUDUM/dev/shm ]; then
    link=$(readlink $SCUDUM/dev/shm)
    mkdir -p $SCUDUM/$link
    mount -vt tmpfs shm $SCUDUM/$link
    unset link
else
    mount -vt tmpfs shm $SCUDUM/dev/shm
fi

cp -rp $(readlink -f "../../../scudum") /tools/repo

chroot $SCUDUM /tools/bin/env -i\
    HOME=/root\
    TERM="$TERM"\
    PS1='\u:\w\$ '\
    PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin\
    /tools/bin/bash $1 --login +h

umount -v $SCUDUM/sys
umount -v $SCUDUM/proc
umount -v $SCUDUM/dev/pts
umount -v $SCUDUM/dev
