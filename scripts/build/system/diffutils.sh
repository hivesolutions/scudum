VERSION=${VERSION-3.3}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/diffutils/diffutils-$VERSION.tar.xz"
rm -rf diffutils-$VERSION && tar -Jxf "diffutils-$VERSION.tar.xz"
rm -f "diffutils-$VERSION.tar.xz"
cd diffutils-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr

make
test $TEST && make check
make install
