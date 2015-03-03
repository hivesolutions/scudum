set -e +h

if [ -e /bin ]; then
    exit 0;
fi

echo "Building initial file structure"

mkdir -pv /{bin,boot,etc/{opt,sysconfig},home,lib,mnt,opt,run}
mkdir -pv /{media/{floppy,cdrom},sbin,srv,var}

install -dv -m 0750 /root
install -dv -m 1777 /tmp /var/tmp

mkdir -pv /usr/{,local/}{bin,include,lib,sbin,src}
mkdir -pv /usr/{,local/}share/{doc,info,locale,man}
mkdir -pv /usr/{,local/}share/{misc,terminfo,zoneinfo}
mkdir -pv /usr/{,local/}share/man/man{1..8}

for dir in /usr /usr/local; do
    ln -svf share/{man,doc,info} $dir
done

case $SCUDUM_ARCH in
    arm*|x86_64)
        ln -svf lib /lib64
        ln -svf lib /usr/lib64
        ln -svf lib /usr/local/lib64
        ;;
esac

mkdir -pv /run/var
mkdir -pv /var/{log,mail,spool}
ln -svf /run /var/run
ln -svf /run/lock /var/lock
mkdir -pv /var/{opt,cache,lib/{misc,locate},local}

echo "Creating symbolic links for know libraries and binaries"

ln -svf /tools/bin/{bash,cat,echo,pwd,stty} /bin
ln -svf /tools/bin/perl /usr/bin
ln -svf /tools/lib/ld-linux-x86-64.so.2 /lib

if [ "$SCUDUM_CROSS" == "1" ]; then
    ln -svf /cross/$ARCH_TARGET/lib/libgcc_s.so{,.1} /usr/lib
    ln -svf /cross/$ARCH_TARGET/lib/libstdc++.so{,.6} /usr/lib
else
    ln -svf /tools/lib/libgcc_s.so{,.1} /usr/lib
    ln -svf /tools/lib/libstdc++.so{,.6} /usr/lib
fi

sed 's/tools/usr/' /tools/lib/libstdc++.la > /usr/lib/libstdc++.la
ln -svf bash /bin/sh

echo "Toucing /etc/mtab file for initial usage"

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

touch /var/log/{btmp,lastlog,wtmp}
chgrp -v utmp /var/log/lastlog
chmod -v 664  /var/log/lastlog
chmod -v 600  /var/log/btmp
