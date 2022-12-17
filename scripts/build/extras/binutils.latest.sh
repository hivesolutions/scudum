VERSION=${VERSION-2.39}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

wget --content-disposition "http://ftp.gnu.org/gnu/binutils/binutils-$VERSION.tar.bz2"
rm -rf binutils-$VERSION && tar -jxf "binutils-$VERSION.tar.bz2"
rm -f "binutils-$VERSION.tar.bz2"
cd binutils-$VERSION

cd ..
rm -rf binutils-build && mkdir binutils-build
cd binutils-build

../binutils-$VERSION/configure\
    --prefix=$PREFIX\
    --enable-gold\
    --enable-ld=default\
    --enable-plugins\
    --enable-shared\
    --disable-werror\
    --disable-multilib\
    --with-system-zlib

make tooldir=$PREFIX
make tooldir=$PREFIX install
