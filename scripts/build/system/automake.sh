VERSION=${VERSION-1.15.1}

set -e +h

wget --no-check-certificate --content-disposition "http://ftp.gnu.org/gnu/automake/automake-$VERSION.tar.xz"
rm -rf automake-$VERSION && tar -Jxf "automake-$VERSION.tar.xz"
rm -f "automake-$VERSION.tar.xz"
cd automake-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr --docdir=/usr/share/doc/automake-$VERSION

make
test $TEST && make check
make install
