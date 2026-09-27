VERSION=${VERSION-2.44}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "https://mirrors.hive.pt/mirrors/scudum/glibc/$VERSION/glibc-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/glibc/glibc-$VERSION.tar.xz"
rget "https://mirrors.hive.pt/mirrors/scudum/glibc/$VERSION/glibc-$VERSION-upstream_fixes-1.patch"\
    "https://www.linuxfromscratch.org/patches/lfs/13.1/glibc-$VERSION-upstream_fixes-1.patch"
rm -rf glibc-$VERSION && tar -Jxf "glibc-$VERSION.tar.xz"
rm -f "glibc-$VERSION.tar.xz"
cd glibc-$VERSION

patch -Np1 -i ../glibc-$VERSION-upstream_fixes-1.patch

cd ..
rm -rf glibc-build && mkdir glibc-build
cd glibc-build

extra="-O2"
[ "$GCC_BUILD_ARCH" != "" ] && extra="-march=$GCC_BUILD_ARCH $extra" || true
[ "$GCC_BUILD_CPU" != "" ] && extra="-mcpu=$GCC_BUILD_CPU $extra" || true
[ "$GCC_BUILD_TUNE" != "" ] && extra="-mtune=$GCC_BUILD_TUNE $extra" || true
[ "$GCC_BUILD_FPU" != "" ] && extra="-mfpu=$GCC_BUILD_FPU $extra" || true
[ "$GCC_BUILD_FLOAT" != "" ] && extra="-m$GCC_BUILD_FLOAT-float $extra" || true

CFLAGS="$extra" ../glibc-$VERSION/configure\
    --prefix=/usr\
    --host=$ARCH_TARGET\
    --build=$(../glibc-$VERSION/scripts/config.guess)\
    --enable-kernel=3.2\
    --disable-multilib\
    --with-headers=$PREFIX_CROSS/sysroot/usr/include\
    libc_cv_forced_unwind=yes\
    libc_cv_c_cleanup=yes

make && make install_root=$PREFIX_CROSS/sysroot install
