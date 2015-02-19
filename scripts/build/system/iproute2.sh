VERSION=${VERSION-3.19.0}

set -e +h

wget --no-check-certificate "http://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-$VERSION.tar.xz"
rm -rf iproute2-$VERSION && tar -Jxf "iproute2-$VERSION.tar.xz"
rm -f "iproute2-$VERSION.tar.xz"
cd iproute2-$VERSION

sed -i '/^TARGETS/s@arpd@@g' misc/Makefile
sed -i /ARPD/d Makefile
sed -i 's/arpd.8//' man/man8/Makefile

sed -i 's/-Werror//' Makefile

if [ "$SCUDUM_CROSS" == "1" ]; then
    make CC=$CC WFLAGS=$CFLAGS M4=/tools/bin/m4 DESTDIR=
    make CC=$CC WFLAGS=$CFLAGS DESTDIR= MANDIR=/usr/share/man\
        DOCDIR=/usr/share/doc/iproute2-$VERSION install
else
    make DESTDIR=
    make DESTDIR= MANDIR=/usr/share/man\
        DOCDIR=/usr/share/doc/iproute2-$VERSION install
fi
