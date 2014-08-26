VERSION="2.4.2"
tar -zxf "libtool-$VERSION.tar.gz"
cd libtool-$VERSION

./configure --prefix=/usr

make
test $TEST && make check
make install

cd ..
rm -rf libtool-$VERSION
