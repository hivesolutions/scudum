VERSION=${VERSION-4.9.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://ftp.gnu.org/gnu/gcc/gcc-$VERSION/gcc-$VERSION.tar.bz2"
rm -rf gcc-$VERSION && tar -jxf "gcc-$VERSION.tar.bz2"
rm -f "gcc-$VERSION.tar.bz2"
cd gcc-$VERSION

cd ..
rm -rf gcc-build && mkdir gcc-build
cd gcc-build

../gcc-$VERSION/configure\
    --prefix=$PREFIX\
    --enable-languages=c,c++\
    --disable-multilib\
    --disable-bootstrap\
    --with-system-zlib

make
make install

ln -svf gcc $PREFIX/bin/cc
