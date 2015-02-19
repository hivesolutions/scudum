VERSION=${VERSION-2.4.2}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/libtool/libtool-$VERSION.tar.gz"
rm -rf libtool-$VERSION && tar -zxf "libtool-$VERSION.tar.gz"
rm -f "libtool-$VERSION.tar.gz"
cd libtool-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr

make
test $TEST && make check
make install
