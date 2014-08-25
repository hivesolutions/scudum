VERSION="2.23.1"
tar -jxf "binutils-$VERSION.tar.bz2"
cd binutils-$VERSION

patch -Np1 -i ../binutils-$VERSION-testsuite_fix-1.patch

rm -fv etc/standards.info
sed -i.bak '/^INFO/s/standards.info //' etc/Makefile.in

mkdir -v ../binutils-build
cd ../binutils-build

../binutils-$VERSION/configure --prefix=/usr --enable-shared

make tooldir=/usr
make check
make tooldir=/usr install

cp -v ../binutils-2.23.1/include/libiberty.h /usr/include

cd ..
rm -rf binutils-build
rm -rf binutils-$VERSION
