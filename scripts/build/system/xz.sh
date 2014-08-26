VERSION=${VERSION-5.0.4}

wget --no-check-certificate "http://tukaani.org/xz/xz-$VERSION.tar.xz"
rm -rf xz-$VERSION && tar -Jxf "xz-$VERSION.tar.xz"
rm -f "xz-$VERSION.tar.xz"
cd xz-$VERSION

./configure --prefix=/usr --libdir=/lib\
    --docdir=/usr/share/doc/xz-$VERSION

    make
test $TEST && make check
make pkgconfigdir=/usr/lib/pkgconfig install
