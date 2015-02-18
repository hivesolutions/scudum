VERSION=${VERSION-4.9.2}
VERSION_MPFR=${VERSION_MPFR-3.1.2}
VERSION_GMP=${VERSION_GMP-6.0.0}
VERSION_MPC=${VERSION_MPC-1.0.2}

set -e +h

wget "http://ftp.gnu.org/gnu/gcc/gcc-$VERSION/gcc-$VERSION.tar.bz2"
rm -rf gcc-$VERSION && tar -jxf "gcc-$VERSION.tar.bz2"
rm -f "gcc-$VERSION.tar.bz2"
cd gcc-$VERSION

cat gcc/limitx.h gcc/glimits.h gcc/limity.h >\
    `dirname $($SCUDUM_TARGET-gcc -print-libgcc-file-name)`/include-fixed/limits.h

for file in $(find gcc/config -name linux64.h -o -name linux.h -o -name sysv4.h); do
    cp -uv $file{,.orig}
    sed -e 's@/lib\(64\)\?\(32\)\?/ld@/cross&@g'\
        -e 's@/usr@/cross@g' $file.orig > $file
    echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/cross/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
    touch $file.orig
done

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

AR=ar LDFLAGS="-Wl,-rpath,$PREFIX_CROSS/lib" ./gcc-$VERSION/configure\
    --target=$ARCH_TARGET\
    --prefix=$PREFIX_CROSS\
    --with-local-prefix=$PREFIX_CROSS\
    --with-native-system-header-dir=$PREFIX_CROSS/include\
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
    --with-mpfr-lib=$(pwd)/mpfr/src/.libs

make && make install

ln -sv $ARCH_TARGET-gcc $PREFIX_CROSS/bin/{cc,gcc}
ln -sv $ARCH_TARGET-g++ $PREFIX_CROSS/bin/{cc++,g++}
