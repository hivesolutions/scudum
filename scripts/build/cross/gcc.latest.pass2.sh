VERSION=${VERSION-5.4.0}
VERSION_MPFR=${VERSION_MPFR-3.1.5}
VERSION_GMP=${VERSION_GMP-6.1.2}
VERSION_MPC=${VERSION_MPC-1.0.3}

set -e +h

wget "http://ftp.gnu.org/gnu/gcc/gcc-$VERSION/gcc-$VERSION.tar.gz"
rm -rf gcc-$VERSION && tar -zxf "gcc-$VERSION.tar.gz"
rm -f "gcc-$VERSION.tar.gz"
cd gcc-$VERSION

cat gcc/limitx.h gcc/glimits.h gcc/limity.h >\
    `dirname $($ARCH_TARGET-gcc -print-libgcc-file-name)`/include-fixed/limits.h

wget "http://www.mpfr.org/mpfr-$VERSION_MPFR/mpfr-$VERSION_MPFR.tar.xz"
tar -Jxf "mpfr-$VERSION_MPFR.tar.xz"
mv mpfr-$VERSION_MPFR mpfr

wget "https://gmplib.org/download/gmp/gmp-$VERSION_GMP.tar.xz"
tar -Jxf "gmp-$VERSION_GMP.tar.xz"
mv gmp-$VERSION_GMP gmp

wget "http://www.multiprecision.org/mpc/download/mpc-$VERSION_MPC.tar.gz"
tar -zxf "mpc-$VERSION_MPC.tar.gz"
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
    --with-mpfr-include=$(pwd)/../gcc-$VERSION/mpfr/src \
    --with-mpfr-lib=$(pwd)/mpfr/src/.libs\
    $extra

make && make install
