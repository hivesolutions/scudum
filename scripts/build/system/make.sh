VERSION=${VERSION-4.4}

set -e +h

wget --no-check-certificate --content-disposition "http://ftp.gnu.org/gnu/make/make-$VERSION.tar.gz"
rm -rf make-$VERSION && tar -zxf "make-$VERSION.tar.gz"
rm -f "make-$VERSION.tar.gz"
cd make-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr

make
test $TEST && make check
make install
