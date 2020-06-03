VERSION=${VERSION-3.2.7}

set -e +h

wget --no-check-certificate --content-disposition "http://dev.gentoo.org/~blueness/eudev/eudev-$VERSION.tar.gz"
rm -rf eudev-$VERSION && tar -zxf "eudev-$VERSION.tar.gz"
rm -f "eudev-$VERSION.tar.gz"
cd eudev-$VERSION

if [ "$SCUDUM_CROSS" == "1" ]; then
    cat > config.cache << "EOF"
HAVE_BLKID=1
BLKID_LIBS="-lblkid"
EOF
else
    cat > config.cache << "EOF"
HAVE_BLKID=1
BLKID_LIBS="-lblkid"
BLKID_CFLAGS="-I/tools/include"
EOF
fi

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --bindir=/sbin\
    --sbindir=/sbin\
    --libdir=/usr/lib\
    --sysconfdir=/etc\
    --libexecdir=/lib\
    --with-rootprefix=\
    --with-rootlibdir=/lib\
    --enable-manpages\
    --disable-static\
    --config-cache

LIBRARY_PATH=/tools/lib make

mkdir -pv /lib/udev/devices
mkdir -pv /lib/udev/devices/pts
mkdir -pv /lib/udev/rules.d
mkdir -pv /etc/udev/rules.d

make LD_LIBRARY_PATH=/tools/lib install
