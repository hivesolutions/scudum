mkdir -pv $SCUDUM/{dev,proc,sys}

# crates the main device nodes with the proper
# flags set for the devices
mknod -m 600 $SCUDUM/dev/console c 5 1
mknod -m 666 $SCUDUM/dev/null c 1 3

mount -v --bind /dev $SCUDUM/dev

mount -vt devpts devpts $SCUDUM/dev/pts
mount -vt proc proc $SCUDUM/proc
mount -vt sysfs sysfs $SCUDUM/sys

if [ -h $SCUDUM/dev/shm ]; then
    link=$(readlink $SCUDUM/dev/shm)
    mkdir -p $SCUDUM/$link
    mount -vt tmpfs shm $SCUDUM/$link
    unset link
else
    mount -vt tmpfs shm $SCUDUM/dev/shm
fi

cp -rp $(readlink  -f "../../scudum") /tools/scripts

chroot $SCUDUM /tools/bin/env -i\
    HOME=/root\
    TERM="$TERM"\
    PS1='\u:\w\$ '\
    PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin\
    /tools/bin/bash /tools/scripts/system.sh --login +h
