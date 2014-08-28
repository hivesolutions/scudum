VERSION=${VERSION-2.24}

set -e

wget --no-check-certificate "http://ftp.gnu.org/gnu/binutils/binutils-$VERSION.tar.bz2"
rm -rf binutils-$VERSION && tar -jxf "binutils-$VERSION.tar.bz2"
rm -f "binutils-$VERSION.tar.bz2"
cd binutils-$VERSION

mkdir -v ../binutils-build
cd ../binutils-build

../binutils-$VERSION/configure --prefix=/usr --enable-shared

make tooldir=/usr
test $TEST && make check
make tooldir=/usr install
