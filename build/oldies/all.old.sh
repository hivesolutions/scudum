






#### ---------------------- Preparation of the virtual environment ----

mkdir -v $SCUDUM/{dev,proc,sys}

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

### ------------------------------- chrooting -----------------------------


chroot "$SCUDUM" /tools/bin/env -i\
    HOME=/root\
    TERM="$TERM"\
    PS1='\u:\w\$ '\
    PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin\
    /tools/bin/bash --login +h

#### -------------------------------- base tree creation -------------------------

mkdir -pv /{bin,boot,etc/{opt,sysconfig},home,lib,mnt,opt,run}
mkdir -pv /{media/{floppy,cdrom},sbin,srv,var}
install -dv -m 0750 /root
install -dv -m 1777 /tmp /var/tmp
mkdir -pv /usr/{,local/}{bin,include,lib,sbin,src}
mkdir -pv /usr/{,local/}share/{doc,info,locale,man}
mkdir -v  /usr/{,local/}share/{misc,terminfo,zoneinfo}
mkdir -pv /usr/{,local/}share/man/man{1..8}
for dir in /usr /usr/local; do
  ln -sv share/{man,doc,info} $dir
done
case $(uname -m) in
 x86_64) ln -sv lib /lib64 && ln -sv lib /usr/lib64 ;;
esac
mkdir -v /var/{log,mail,spool}
ln -sv /run /var/run
ln -sv /run/lock /var/lock
mkdir -pv /var/{opt,cache,lib/{misc,locate},local}

ln -sv /tools/bin/{bash,cat,echo,pwd,stty} /bin
ln -sv /tools/bin/perl /usr/bin
ln -sv /tools/lib/libgcc_s.so{,.1} /usr/lib
ln -sv /tools/lib/libstdc++.so{,.6} /usr/lib
sed 's/tools/usr/' /tools/lib/libstdc++.la > /usr/lib/libstdc++.la
ln -sv bash /bin/sh

touch /etc/mtab

cat > /etc/passwd << "EOF"
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/dev/null:/bin/false
nobody:x:99:99:Unprivileged User:/dev/null:/bin/false
EOF

cat > /etc/group << "EOF"
root:x:0:
bin:x:1:
sys:x:2:
kmem:x:3:
tape:x:4:
tty:x:5:
daemon:x:6:
floppy:x:7:
disk:x:8:
lp:x:9:
dialout:x:10:
audio:x:11:
video:x:12:
utmp:x:13:
usb:x:14:
cdrom:x:15:
mail:x:34:
nogroup:x:99:
EOF

# changes the current user to the currently
# set root user (bash back to normal)
exec /tools/bin/bash --login +h

# creates the various log files to be used
# for normal logging operations
touch /var/log/{btmp,lastlog,wtmp}
chgrp -v utmp /var/log/lastlog
chmod -v 664 /var/log/lastlog
chmod -v 600 /var/log/btmp

####################### BUILD THE STUFF #######

cd sources

### KERNEL HEADERS ###############

VERSION="3.8.2"
tar -Jxf "linux-$VERSION.tar.xz"
cd linux-$VERSION

make mrproper

make headers_check
make INSTALL_HDR_PATH=dest headers_install
find dest/include \( -name .install -o -name ..install.cmd \) -delete
cp -rv dest/include/* /usr/include

cd ..
rm -rf cd linux-$VERSION

#### man pages

VERSION="3.47"
tar -Jxf "man-pages-$VERSION.tar.xz"
cd man-pages-$VERSION

make install

cd ..
rm -rf man-pages-$VERSION

#### glibc (final)

VERSION="2.17"
tar -Jxf "glibc-$VERSION.tar.xz"
cd glibc-$VERSION

mkdir -v ../glibc-build
cd ../glibc-build

../glibc-$VERSION/configure\
    --prefix=/usr\
    --disable-profile\
    --enable-kernel=2.6.25\
    --libexecdir=/usr/lib/glibc

make
make -k check 2>&1 | tee glibc-check-log
grep Error glibc-check-log

touch /etc/ld.so.conf
make install

# installs nis and rpc related headers that are
# not installed by default
cp -v ../glibc-2.17/sunrpc/rpc/*.h /usr/include/rpc
cp -v ../glibc-2.17/sunrpc/rpcsvc/*.h /usr/include/rpcsvc
cp -v ../glibc-2.17/nis/rpcsvc/*.h /usr/include/rpcsvc

# defines the the various locales that are going
# ot be used by the base libraries compilation
mkdir -pv /usr/lib/locale
localedef -i cs_CZ -f UTF-8 cs_CZ.UTF-8
localedef -i de_DE -f ISO-8859-1 de_DE
localedef -i de_DE@euro -f ISO-8859-15 de_DE@euro
localedef -i de_DE -f UTF-8 de_DE.UTF-8
localedef -i en_GB -f UTF-8 en_GB.UTF-8
localedef -i en_HK -f ISO-8859-1 en_HK
localedef -i en_PH -f ISO-8859-1 en_PH
localedef -i en_US -f ISO-8859-1 en_US
localedef -i en_US -f UTF-8 en_US.UTF-8
localedef -i es_MX -f ISO-8859-1 es_MX
localedef -i fa_IR -f UTF-8 fa_IR
localedef -i fr_FR -f ISO-8859-1 fr_FR
localedef -i fr_FR@euro -f ISO-8859-15 fr_FR@euro
localedef -i fr_FR -f UTF-8 fr_FR.UTF-8
localedef -i it_IT -f ISO-8859-1 it_IT
localedef -i it_IT -f UTF-8 it_IT.UTF-8
localedef -i ja_JP -f EUC-JP ja_JP
localedef -i ru_RU -f KOI8-R ru_RU.KOI8-R
localedef -i ru_RU -f UTF-8 ru_RU.UTF-8
localedef -i tr_TR -f UTF-8 tr_TR.UTF-8
localedef -i zh_CN -f GB18030 zh_CN.GB18030

make localedata/install-locales

cat > /etc/nsswitch.conf << "EOF"
passwd: files
group: files
shadow: files

hosts: files dns
networks: files

protocols: files
services: files
ethers: files
rpc: files

EOF

#timezone related stuff (still for glibc)
tar -xf ../tzdata2012j.tar.gz

ZONEINFO=/usr/share/zoneinfo
mkdir -pv $ZONEINFO/{posix,right}

for tz in etcetera southamerica northamerica europe africa antarctica  \
          asia australasia backward pacificnew solar87 solar88 solar89 \
          systemv; do
    zic -L /dev/null   -d $ZONEINFO       -y "sh yearistype.sh" ${tz}
    zic -L /dev/null   -d $ZONEINFO/posix -y "sh yearistype.sh" ${tz}
    zic -L leapseconds -d $ZONEINFO/right -y "sh yearistype.sh" ${tz}
done

cp -v zone.tab iso3166.tab $ZONEINFO
zic -d $ZONEINFO -p America/New_York
unset ZONEINFO

cat > /etc/ld.so.conf << "EOF"
/usr/local/lib
/opt/lib

EOF

cat >> /etc/ld.so.conf << "EOF"
# Add an include directory
include /etc/ld.so.conf.d/*.conf

EOF
mkdir /etc/ld.so.conf.d

cd ..
rm -rf glibc-build
rm -rf glibc-$VERSION

##### ADJUSTING TOOLCHAIN 6.10

mv -v /tools/bin/{ld,ld-old}
mv -v /tools/$(gcc -dumpmachine)/bin/{ld,ld-old}
mv -v /tools/bin/{ld-new,ld}
ln -sv /tools/bin/ld /tools/$(gcc -dumpmachine)/bin/ld

gcc -dumpspecs | sed -e 's@/tools@@g'\
    -e '/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}'\
    -e '/\*cpp:/{n;s@$@ -isystem /usr/include@}' >\
    `dirname $(gcc --print-libgcc-file-name)`/specs


## The user mode tools to be instaled in the system

../bin/zlib.sh
../bin/file.sh
../bin/binutils.sh
../bin/gmp.sh
../bin/mpfr.sh
../bin/mpc.sh
../bin/gcc.sh
../bin/sed.sh
../bin/bzip2.sh
../bin/pkg-config.sh
../bin/ncurses.sh
../bin/util-unix.sh
../bin/psmisc.sh
../bin/procps-ng.sh
../bin/e2fsprogs.sh
../bin/shadow.sh
../bin/coreutils.sh
../bin/iana-etc.sh
../bin/m4.sh
../bin/bison.sh
../bin/grep.sh
../bin/readline.sh
../bin/bash.sh
../bin/libtool.sh
../bin/gdbm.sh
../bin/inetutils.sh
../bin/perl.sh
../bin/autoconf.sh
../bin/automake.sh
../bin/autoconf.sh
../bin/diffutils.sh
../bin/gawk.sh
../bin/findutils.sh
../bin/flex.sh
../bin/gettext.sh
../bin/groff.sh
../bin/xz.sh
../bin/grub.sh
../bin/less.sh
../bin/gzip.sh
../bin/iproute2.sh
../bin/kbd.sh
../bin/kmod.sh
../bin/libpipeline.sh
../bin/make.sh
../bin/man-db.sh
../bin/patch.sh
../bin/sysklogd.sh
../bin/sysvinit.sh
../bin/tar.sh
../bin/texinfo.sh
../bin/udev.sh
../bin/vim.sh
../bin/nano.sh

##### final stateges  (6.64. Stripping Again)

logout

chroot $SCUDUM /tools/bin/env -i\
    HOME=/root TERM=$TERM PS1='\u:\w\$ '\
    PATH=/bin:/usr/bin:/sbin:/usr/sbin\
    /tools/bin/bash --login

/tools/bin/find /{,usr/}{bin,lib,sbin} -type f\
    -exec /tools/bin/strip --strip-debug '{}' ';'

#### removal of the /tools directory

logout

chroot $SCUDUM /usr/bin/env -i\
    HOME=/root TERM="$TERM" PS1='\u:\w\$ '\
    PATH=/bin:/usr/bin:/sbin:/usr/sbin\
    /bin/bash --login

rm -rf /tools

### configure the bootscripts

../bin/bootscripts.sh


cat > /etc/inittab << "EOF"
id:3:initdefault:

si::sysinit:/etc/rc.d/init.d/rc S

l0:0:wait:/etc/rc.d/init.d/rc 0
l1:S1:wait:/etc/rc.d/init.d/rc 1
l2:2:wait:/etc/rc.d/init.d/rc 2
l3:3:wait:/etc/rc.d/init.d/rc 3
l4:4:wait:/etc/rc.d/init.d/rc 4
l5:5:wait:/etc/rc.d/init.d/rc 5
l6:6:wait:/etc/rc.d/init.d/rc 6

ca:12345:ctrlaltdel:/sbin/shutdown -t1 -a -r now

su:S016:once:/sbin/sulogin

1:2345:respawn:/sbin/agetty --noclear tty1 9600
2:2345:respawn:/sbin/agetty tty2 9600
3:2345:respawn:/sbin/agetty tty3 9600
4:2345:respawn:/sbin/agetty tty4 9600
5:2345:respawn:/sbin/agetty tty5 9600
6:2345:respawn:/sbin/agetty tty6 9600

EOF

### hostname

echo "HOSTNAME=scudum" > /etc/sysconfig/network

### clock

cat > /etc/sysconfig/clock << "EOF"
# Sets the clock to the UTC timezone by default, this should
# be the default configuration for most of the systems
UTC=1

# Set this to any options you might need to give to hwclock,
# such as machine hardware clock type for Alphas.
CLOCKPARAMS=

EOF

#### console (ignored)

#### /etc/fstab   (must be customized)

cat > /etc/fstab << "EOF"
# file system  mount-point  type     options             dump  fsck
#                                                              order

/dev/sda1      /boot        ext2     noauto,noatime      1     2
/dev/sda3      /            ext3     defaults,noatime    0     1
/dev/sda2      none         swap     pri=1               0     0
proc           /proc        proc     nosuid,noexec,nodev 0     0
sysfs          /sys         sysfs    nosuid,noexec,nodev 0     0
devpts         /dev/pts     devpts   gid=5,mode=620      0     0
tmpfs          /run         tmpfs    defaults            0     0
devtmpfs       /dev         devtmpfs mode=0755,nosuid    0     0
EOF


### KERNEL


make mrproper
make menuconfig
make

VERSION="3.8.2"

cp -v arch/x86_64/boot/bzImage /boot/vmlinuz-$VERSION
cp -v System.map /boot/System.map-$VERSION
cp -v .config /boot/config-$VERSION


### GRUB (requires configuration)

## URGENTE para instalar o grub tenho de ter o dev file system instalado


grub-install /dev/sdb

cat > /boot/grub/grub.cfg << "EOF"
set default=0
set timeout=5

insmod ext2
set root=(hd0,1)

menuentry "GNU/Linux, Linux 3.8.2" {
    linux /vmlinuz-3.8.2 root=/dev/sda3 ro
}

EOF

#### remove temporary files

cd /tmp
rm -rf .[^.]* ..?*

cd /root
rm -rf .[^.]* ..?*
