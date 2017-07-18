VERSION=${VERSION-2.28}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/binutils/binutils-$VERSION.tar.bz2"
rm -rf binutils-$VERSION && tar -jxf "binutils-$VERSION.tar.bz2"
rm -f "binutils-$VERSION.tar.bz2"
cd binutils-$VERSION

cd ..
rm -rf binutils-build && mkdir binutils-build
cd binutils-build

../binutils-$VERSION/configure --host=$ARCH_TARGET --prefix=/usr --enable-shared

make tooldir=/usr
test $TEST && make check
make tooldir=/usr install
