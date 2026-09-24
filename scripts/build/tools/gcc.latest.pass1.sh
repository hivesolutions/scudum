VERSION=${VERSION-16.2.0}
VERSION_MPFR=${VERSION_MPFR-4.2.2}
VERSION_GMP=${VERSION_GMP-6.3.0}
VERSION_MPC=${VERSION_MPC-1.4.1}
VERSION_GLIBC=${VERSION_GLIBC-2.44}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "https://mirrors.hive.pt/mirrors/scudum/gcc/$VERSION/gcc-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/gcc/gcc-$VERSION/gcc-$VERSION.tar.xz"
rm -rf gcc-$VERSION && tar -Jxf "gcc-$VERSION.tar.xz"
rm -f "gcc-$VERSION.tar.xz"
cd gcc-$VERSION

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
    --with-glibc-version=$VERSION_GLIBC\
    --with-sysroot=$SCUDUM\
    --with-newlib\
    --without-headers\
    --enable-default-pie\
    --enable-default-ssp\
    --disable-fixincludes\
    --disable-nls\
    --disable-shared\
    --disable-multilib\
    --disable-threads\
    --disable-libatomic\
    --disable-libgomp\
    --disable-libquadmath\
    --disable-libssp\
    --disable-libvtv\
    --disable-libstdcxx\
    --enable-languages=c,c++

make && make install

cat ../gcc-$VERSION/gcc/limitx.h ../gcc-$VERSION/gcc/glimits.h ../gcc-$VERSION/gcc/limity.h >\
    $($SCUDUM_TARGET-gcc -print-file-name=include)/limits.h
