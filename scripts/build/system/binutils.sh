VERSION=${VERSION-2.23.1}

set -e

wget --no-check-certificate "http://ftp.gnu.org/gnu/binutils/binutils-$VERSION.tar.bz2"
rm -rf binutils-$VERSION && tar -jxf "binutils-$VERSION.tar.bz2"
rm -f "binutils-$VERSION.tar.bz2"
cd binutils-$VERSION

wget --no-check-certificate "http://www.linuxfromscratch.org/patches/lfs/7.3/binutils-$VERSION-testsuite_fix-1.patch"
patch -Np1 -i binutils-$VERSION-testsuite_fix-1.patch

rm -fv etc/standards.info
sed -i.bak '/^INFO/s/standards.info //' etc/Makefile.in

mkdir -v ../binutils-build
cd ../binutils-build

../binutils-$VERSION/configure --prefix=/usr --enable-shared

make tooldir=/usr
test $TEST && make check
make tooldir=/usr install

cp -v ../binutils-2.23.1/include/libiberty.h /usr/include
