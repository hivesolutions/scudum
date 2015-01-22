VERSION=${VERSION-4.9.2}

set -e +h

wget "http://ftp.gnu.org/gnu/gcc/gcc-$VERSION/gcc-$VERSION.tar.bz2"
rm -rf gcc-$VERSION && tar -jxf "gcc-$VERSION.tar.bz2"
rm -f "gcc-$VERSION.tar.bz2"
cd gcc-$VERSION

cd ..
rm -rf gcc-build && mkdir gcc-build
cd gcc-build

../gcc-$VERSION/libstdc++-v3/configure\
    --host=$SCUDUM_TARGET\
    --prefix=$PREFIX\
    --disable-multilib\
    --disable-shared\
    --disable-nls\
    --disable-libstdcxx-threads\
    --disable-libstdcxx-pch\
    --with-gxx-include-dir=$PREFIX/$SCUDUM_TARGET/include/c++/$VERSION

make && make install
