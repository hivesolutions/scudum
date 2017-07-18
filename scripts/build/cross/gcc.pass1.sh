VERSION=${VERSION-4.8.5}
VERSION_MPFR=${VERSION_MPFR-3.1.2}
VERSION_GMP=${VERSION_GMP-6.0.0}
VERSION_MPC=${VERSION_MPC-1.0.2}

set -e +h

wget "http://ftp.gnu.org/gnu/gcc/gcc-$VERSION/gcc-$VERSION.tar.gz"
rm -rf gcc-$VERSION && tar -zxf "gcc-$VERSION.tar.gz"
rm -f "gcc-$VERSION.tar.gz"
cd gcc-$VERSION

wget "http://www.mpfr.org/mpfr-$VERSION_MPFR/mpfr-$VERSION_MPFR.tar.xz"
tar -Jxf "mpfr-$VERSION_MPFR.tar.xz"
mv mpfr-$VERSION_MPFR mpfr

wget "https://gmplib.org/download/gmp/gmp-$VERSION_GMP.tar.xz"
tar -Jxf "gmp-$VERSION_GMP.tar.xz"
mv gmp-$VERSION_GMP gmp

wget "http://www.multiprecision.org/mpc/download/mpc-$VERSION_MPC.tar.gz"
tar -zxf "mpc-$VERSION_MPC.tar.gz"
mv mpc-$VERSION_MPC mpc

sed -i '/k prot/agcc_cv_libc_provides_ssp=yes' gcc/configure

cd ..
rm -rf gcc-build && mkdir gcc-build
cd gcc-build

extra=""
[ "$GCC_BUILD_ARCH" != "" ] && extra="--with-arch=$GCC_BUILD_ARCH $extra" || true
[ "$GCC_BUILD_CPU" != "" ] && extra="--with-cpu=$GCC_BUILD_CPU $extra" || true
[ "$GCC_BUILD_TUNE" != "" ] && extra="--with-tune=$GCC_BUILD_TUNE $extra" || true
[ "$GCC_BUILD_FPU" != "" ] && extra="--with-fpu=$GCC_BUILD_FPU $extra" || true
[ "$GCC_BUILD_FLOAT" != "" ] && extra="--with-float=$GCC_BUILD_FLOAT $extra" || true

../gcc-$VERSION/configure\
    --target=$ARCH_TARGET\
    --prefix=$PREFIX_CROSS\
    --with-sysroot=$PREFIX_CROSS/sysroot\
    --with-newlib\
    --without-headers\
    --with-local-prefix=$PREFIX_CROSS/sysroot\
    --disable-nls\
    --disable-shared\
    --disable-multilib\
    --disable-decimal-float\
    --disable-threads\
    --disable-libatomic\
    --disable-libgomp\
    --disable-libitm\
    --disable-libmudflap\
    --disable-libquadmath\
    --disable-libsanitizer\
    --disable-libssp\
    --disable-libstdc++-v3\
    --enable-languages=c,c++\
    --with-mpfr-include=$(pwd)/../gcc-$VERSION/mpfr/src \
    --with-mpfr-lib=$(pwd)/mpfr/src/.libs\
    $extra

make && make install
ln -svf libgcc.a `$ARCH_TARGET-gcc -print-libgcc-file-name | sed 's/libgcc/&_eh/'`
