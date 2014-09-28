VERSION=${VERSION-4.9.1}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/gcc/gcc-$VERSION/gcc-$VERSION.tar.bz2"
rm -rf gcc-$VERSION && tar -jxf "gcc-$VERSION.tar.bz2"
rm -f "gcc-$VERSION.tar.bz2"
cd gcc-$VERSION

cd ..
rm -rf gcc-build && mkdir gcc-build
cd gcc-build

../gcc-$VERSION/configure\
    --prefix=$PREFIX\
    --target=$(uname -m)-pc-linux-gnu\
    --enable-languages=c,c++\
    --disable-multilib\
    --disable-bootstrap\
    --with-system-zlib

make
make install

ln -sv gcc $PREFIX/bin/cc
