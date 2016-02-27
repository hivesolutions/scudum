VERSION=${VERSION-4.9.3}
VERSION_MPFR=${VERSION_MPFR-3.1.2}
VERSION_GMP=${VERSION_GMP-6.0.0}
VERSION_MPC=${VERSION_MPC-1.0.2}

set -e +h

wget "http://ftp.gnu.org/gnu/gcc/gcc-$VERSION/gcc-$VERSION.tar.bz2"
rm -rf gcc-$VERSION && tar -jxf "gcc-$VERSION.tar.bz2"
rm -f "gcc-$VERSION.tar.bz2"
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

for file in $(find gcc/config -name linux64.h -o -name linux.h -o -name sysv4.h); do
    cp -uv $file{,.orig}
    sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g'\
        -e 's@/usr@/tools@g' $file.orig > $file
    echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
    touch $file.orig
done

sed -i '/k prot/agcc_cv_libc_provides_ssp=yes' gcc/configure

cd ..
rm -rf gcc-build && mkdir gcc-build
cd gcc-build

../gcc-$VERSION/configure\
    --target=$SCUDUM_TARGET\
    --prefix=$PREFIX\
    --with-sysroot=$SCUDUM\
    --with-newlib\
    --without-headers\
    --with-local-prefix=$PREFIX\
    --with-native-system-header-dir=$PREFIX/include\
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
    --disable-libvtv\
    --disable-libcilkrts\
    --disable-libstdc++-v3\
    --enable-languages=c,c++\
    --with-mpfr-include=$(pwd)/../gcc-$VERSION/mpfr/src \
    --with-mpfr-lib=$(pwd)/mpfr/src/.libs

make && make install
ln -sv libgcc.a `$SCUDUM_TARGET-gcc -print-libgcc-file-name | sed 's/libgcc/&_eh/'`
