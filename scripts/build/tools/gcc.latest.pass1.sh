VERSION=${VERSION-8.2.0}
VERSION_MPFR=${VERSION_MPFR-4.0.1}
VERSION_GMP=${VERSION_GMP-6.1.2}
VERSION_MPC=${VERSION_MPC-1.1.0}

set -e +h

wget --content-disposition "http://ftp.gnu.org/gnu/gcc/gcc-$VERSION/gcc-$VERSION.tar.gz"
rm -rf gcc-$VERSION && tar -zxf "gcc-$VERSION.tar.gz"
rm -f "gcc-$VERSION.tar.gz"
cd gcc-$VERSION

wget --content-disposition "http://ftp.gnu.org/gnu/mpfr/mpfr-$VERSION_MPFR.tar.xz"
tar -Jxf "mpfr-$VERSION_MPFR.tar.xz"
mv mpfr-$VERSION_MPFR mpfr

wget --content-disposition "http://ftp.gnu.org/gnu/gmp/gmp-$VERSION_GMP.tar.xz"
tar -Jxf "gmp-$VERSION_GMP.tar.xz"
mv gmp-$VERSION_GMP gmp

wget --content-disposition "http://ftp.gnu.org/gnu/mpc/mpc-$VERSION_MPC.tar.gz"
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

case $SCUDUM_HOST in
    x86_64)
        sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
    ;;
esac

cd ..
rm -rf gcc-build && mkdir gcc-build
cd gcc-build

../gcc-$VERSION/configure\
    --target=$SCUDUM_TARGET\
    --prefix=$PREFIX\
    --with-glibc-version=2.11\
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
    --disable-libmpx\
    --disable-libquadmath\
    --disable-libssp\
    --disable-libvtv\
    --disable-libstdcxx\
    --enable-languages=c,c++\
    --with-mpfr-include=$(pwd)/../gcc-$VERSION/mpfr/src \
    --with-mpfr-lib=$(pwd)/mpfr/src/.libs

make && make install
