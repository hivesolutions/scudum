VERSION=${VERSION-4.18.0}

set -e +h

wget --no-check-certificate "http://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-$VERSION.tar.xz"
rm -rf iproute2-$VERSION && tar -Jxf "iproute2-$VERSION.tar.xz"
rm -f "iproute2-$VERSION.tar.xz"
cd iproute2-$VERSION

if [ "$SCUDUM_CROSS" == "1" ]; then
    make CC="$CC" HOSTCC=gcc M4=/tools/bin/m4 DESTDIR=
    make CC="$CC" HOSTCC=gcc DESTDIR= MANDIR=/usr/share/man\
        DOCDIR=/usr/share/doc/iproute2-$VERSION install
else
    make DESTDIR=
    make DESTDIR= MANDIR=/usr/share/man\
        DOCDIR=/usr/share/doc/iproute2-$VERSION install
fi
