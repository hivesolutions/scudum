VERSION=${VERSION-3.1.5}

set -e +h

wget --no-check-certificate "http://dev.gentoo.org/~blueness/eudev/eudev-$VERSION.tar.gz"
rm -rf eudev-$VERSION && tar -zxf "eudev-$VERSION.tar.gz"
rm -f "eudev-$VERSION.tar.gz"
cd eudev-$VERSION

sed -r -i 's|/usr(/bin/test)|\1|' test/udev-test.pl

if [ "$SCUDUM_CROSS" == "1" ]; then
    cat > config.cache << "EOF"
HAVE_BLKID=1
BLKID_LIBS="-lblkid"
BLKID_CFLAGS="-I/tools/include"
EOF
else
    cat > config.cache << "EOF"
HAVE_BLKID=1
BLKID_LIBS="-lblkid"
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
    --enable-split-usr\
    --enable-manpages\
    --enable-hwdb\
    --disable-introspection\
    --disable-static\
    --config-cache

LIBRARY_PATH=/tools/lib make

mkdir -pv /lib/udev/rules.d
mkdir -pv /etc/udev/rules.d

make LD_LIBRARY_PATH=/tools/lib install
