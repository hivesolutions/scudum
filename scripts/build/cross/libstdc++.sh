VERSION=${VERSION-$GCC_BUILD_VERSION}

set -e +h

wget "http://ftp.gnu.org/gnu/gcc/gcc-$VERSION/gcc-$VERSION.tar.bz2"
rm -rf gcc-$VERSION && tar -jxf "gcc-$VERSION.tar.bz2"
rm -f "gcc-$VERSION.tar.bz2"
cd gcc-$VERSION

cd ..
rm -rf gcc-build && mkdir gcc-build
cd gcc-build

../gcc-$VERSION/libstdc++-v3/configure\
    --host=$ARCH_TARGET\
    --prefix=$PREFIX_CROSS\
    --disable-multilib\
    --disable-shared\
    --disable-nls\
    --disable-libstdcxx-threads\
    --disable-libstdcxx-pch\
    --with-gxx-include-dir=$PREFIX_CROSS/$ARCH_TARGET/include/c++/$VERSION

make && make install