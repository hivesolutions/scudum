VERSION="1.13.1"
tar -Jxf "automake-$VERSION.tar.xz"
cd automake-$VERSION

./configure --prefix=/usr --docdir=/usr/share/doc/automake-$VERSION
make
test $TEST && make check
make install

cd ..
rm -rf automake-$VERSION
