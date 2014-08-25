VERSION="5.0.4"
tar -Jxf "xz-$VERSION.tar.xz"
cd xz-$VERSION

./configure --prefix=/usr --libdir=/lib\
    --docdir=/usr/share/doc/xz-$VERSION
make
test $TEST && make check
make pkgconfigdir=/usr/lib/pkgconfig install

cd ..
rm -rf xz-$VERSION
