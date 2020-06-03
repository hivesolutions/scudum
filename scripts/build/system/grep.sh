VERSION=${VERSION-3.1}

set -e +h

wget --no-check-certificate --content-disposition "http://ftp.gnu.org/gnu/grep/grep-$VERSION.tar.xz"
rm -rf grep-$VERSION && tar -Jxf "grep-$VERSION.tar.xz"
rm -f "grep-$VERSION.tar.xz"
cd grep-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr --bindir=/bin

make
test $TEST && make check
make install
