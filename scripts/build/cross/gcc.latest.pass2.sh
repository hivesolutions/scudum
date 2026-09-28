VERSION=${VERSION-16.2.0}
VERSION_MPFR=${VERSION_MPFR-4.2.2}
VERSION_GMP=${VERSION_GMP-6.3.0}
VERSION_MPC=${VERSION_MPC-1.4.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "https://mirrors.hive.pt/mirrors/scudum/gcc/$VERSION/gcc-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/gcc/gcc-$VERSION/gcc-$VERSION.tar.xz"
rm -rf gcc-$VERSION && tar -Jxf "gcc-$VERSION.tar.xz"
rm -f "gcc-$VERSION.tar.xz"
cd gcc-$VERSION

cat gcc/limitx.h gcc/glimits.h gcc/limity.h >\
    `dirname $($ARCH_TARGET-gcc -print-libgcc-file-name)`/include-fixed/limits.h

rget "https://mirrors.hive.pt/mirrors/scudum/mpfr/$VERSION_MPFR/mpfr-$VERSION_MPFR.tar.xz"\
    "https://ftpmirror.gnu.org/mpfr/mpfr-$VERSION_MPFR.tar.xz"
tar -Jxf "mpfr-$VERSION_MPFR.tar.xz"
mv mpfr-$VERSION_MPFR mpfr

rget "https://mirrors.hive.pt/mirrors/scudum/gmp/$VERSION_GMP/gmp-$VERSION_GMP.tar.xz"\
    "https://ftpmirror.gnu.org/gmp/gmp-$VERSION_GMP.tar.xz"
tar -Jxf "gmp-$VERSION_GMP.tar.xz"
mv gmp-$VERSION_GMP gmp

rget "https://mirrors.hive.pt/mirrors/scudum/mpc/$VERSION_MPC/mpc-$VERSION_MPC.tar.xz"\
    "https://ftpmirror.gnu.org/mpc/mpc-$VERSION_MPC.tar.xz"
tar -Jxf "mpc-$VERSION_MPC.tar.xz"
mv mpc-$VERSION_MPC mpc

cd ..
rm -rf gcc-build && mkdir gcc-build
cd gcc-build

extra=""
[ "$GCC_BUILD_ARCH" != "" ] && extra="--with-arch=$GCC_BUILD_ARCH $extra" || true
[ "$GCC_BUILD_CPU" != "" ] && extra="--with-cpu=$GCC_BUILD_CPU $extra" || true
[ "$GCC_BUILD_TUNE" != "" ] && extra="--with-tune=$GCC_BUILD_TUNE $extra" || true
[ "$GCC_BUILD_FPU" != "" ] && extra="--with-fpu=$GCC_BUILD_FPU $extra" || true
[ "$GCC_BUILD_FLOAT" != "" ] && extra="--with-float=$GCC_BUILD_FLOAT $extra" || true

AR=ar LDFLAGS="-Wl,-rpath,$PREFIX_CROSS/sysroot/lib" ../gcc-$VERSION/configure\
    --target=$ARCH_TARGET\
    --prefix=$PREFIX_CROSS\
    --with-sysroot=$PREFIX_CROSS/sysroot\
    --with-local-prefix=$PREFIX_CROSS/sysroot\
    --enable-clocale=gnu\
    --enable-shared\
    --enable-threads=posix\
    --enable-__cxa_atexit\
    --enable-languages=c,c++\
    --disable-libstdcxx-pch\
    --disable-multilib\
    --disable-bootstrap\
    --disable-libgomp\
    --disable-libsanitizer\
    --without-zstd\
    --with-mpfr-include=$(pwd)/../gcc-$VERSION/mpfr/src \
    --with-mpfr-lib=$(pwd)/mpfr/src/.libs\
    $extra

make && make install
