VERSION=${VERSION-4.2.1}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/make/make-$VERSION.tar.bz2"
rm -rf make-$VERSION && tar -jxf "make-$VERSION.tar.bz2"
rm -f "make-$VERSION.tar.bz2"
cd make-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr

make
test $TEST && make check
make install
