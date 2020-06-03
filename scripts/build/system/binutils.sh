VERSION=${VERSION-2.31.1}

set -e +h

wget --no-check-certificate --content-disposition "http://ftp.gnu.org/gnu/binutils/binutils-$VERSION.tar.bz2"
rm -rf binutils-$VERSION && tar -jxf "binutils-$VERSION.tar.bz2"
rm -f "binutils-$VERSION.tar.bz2"
cd binutils-$VERSION

cd ..
rm -rf binutils-build && mkdir binutils-build
cd binutils-build

../binutils-$VERSION/configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --enable-gold\
    --enable-ld=default\
    --enable-plugins\
    --enable-shared\
    --disable-werror\
    --with-system-zlib

make tooldir=/usr
test $TEST && make check
make tooldir=/usr install
