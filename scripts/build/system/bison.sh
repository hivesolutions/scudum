VERSION=${VERSION-3.0.4}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/bison/bison-$VERSION.tar.xz"
rm -rf bison-$VERSION && tar -Jxf "bison-$VERSION.tar.xz"
rm -f "bison-$VERSION.tar.xz"
cd bison-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr

make
test $TEST && make check
make install
