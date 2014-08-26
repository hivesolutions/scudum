VERSION=${VERSION-2.69}

rm -rf autoconf-$VERSION && tar -Jxf "autoconf-$VERSION.tar.xz"
rm -f "autoconf-$VERSION.tar.xz"
cd autoconf-$VERSION

./configure --prefix=/usr

make
test $TEST && make check
make install
