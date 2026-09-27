VERSION=${VERSION-$GCC_BUILD_VERSION}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "https://mirrors.hive.pt/mirrors/scudum/gcc/$VERSION/gcc-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/gcc/gcc-$VERSION/gcc-$VERSION.tar.xz"
rm -rf gcc-$VERSION && tar -Jxf "gcc-$VERSION.tar.xz"
rm -f "gcc-$VERSION.tar.xz"
cd gcc-$VERSION

cd ..
rm -rf gcc-build && mkdir gcc-build
cd gcc-build

extra="-O2"
[ "$GCC_BUILD_ARCH" != "" ] && extra="-march=$GCC_BUILD_ARCH $extra" || true
[ "$GCC_BUILD_CPU" != "" ] && extra="-mcpu=$GCC_BUILD_CPU $extra" || true
[ "$GCC_BUILD_TUNE" != "" ] && extra="-mtune=$GCC_BUILD_TUNE $extra" || true
[ "$GCC_BUILD_FPU" != "" ] && extra="-mfpu=$GCC_BUILD_FPU $extra" || true
[ "$GCC_BUILD_FLOAT" != "" ] && extra="-m$GCC_BUILD_FLOAT-float $extra" || true

CFLAGS="$extra" ../gcc-$VERSION/libstdc++-v3/configure\
    --host=$ARCH_TARGET\
    --prefix=$PREFIX_CROSS/sysroot\
    --disable-multilib\
    --disable-nls\
    --disable-libstdcxx-threads\
    --disable-libstdcxx-pch\
    --with-gxx-include-dir=$PREFIX_CROSS/$ARCH_TARGET/include/c++/$VERSION

make && make install
