VERSION=${VERSION-$GCC_BUILD_VERSION}

set -e +h

wget "http://ftp.gnu.org/gnu/gcc/gcc-$VERSION/gcc-$VERSION.tar.gz"
rm -rf gcc-$VERSION && tar -zxf "gcc-$VERSION.tar.gz"
rm -f "gcc-$VERSION.tar.gz"
cd gcc-$VERSION

cd ..
rm -rf gcc-build && mkdir gcc-build
cd gcc-build

../gcc-$VERSION/libstdc++-v3/configure\
    --host=$SCUDUM_TARGET\
    --prefix=$PREFIX\
    --disable-multilib\
    --disable-nls\
    --disable-libstdcxx-threads\
    --disable-libstdcxx-pch\
    --with-gxx-include-dir=$PREFIX/$SCUDUM_TARGET/include/c++/$VERSION

make && make install
