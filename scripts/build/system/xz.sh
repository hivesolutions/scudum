VERSION=${VERSION-5.2.1}

set -e +h

wget --no-check-certificate "http://tukaani.org/xz/xz-$VERSION.tar.xz"
rm -rf xz-$VERSION && tar -Jxf "xz-$VERSION.tar.xz"
rm -f "xz-$VERSION.tar.xz"
cd xz-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr --libdir=/lib\
    --docdir=/usr/share/doc/xz-$VERSION

make
test $TEST && make check
make pkgconfigdir=/usr/lib/pkgconfig install
