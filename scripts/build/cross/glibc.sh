VERSION=${VERSION-2.20}

set -e +h

wget "http://ftp.gnu.org/gnu/glibc/glibc-$VERSION.tar.xz"
rm -rf glibc-$VERSION && tar -Jxf "glibc-$VERSION.tar.xz"
rm -f "glibc-$VERSION.tar.xz"
cd glibc-$VERSION

cd ..
rm -rf glibc-build && mkdir glibc-build
cd glibc-build

extra="-O2"
[ "$GCC_BUILD_ARCH" != "" ] && extra="-march=$GCC_BUILD_ARCH $extra"
[ "$GCC_BUILD_CPU" != "" ] && extra="-mcpu=$GCC_BUILD_CPU $extra"
[ "$GCC_BUILD_TUNE" != "" ] && extra="-mtune=$GCC_BUILD_TUNE $extra"
[ "$GCC_BUILD_FPU" != "" ] && extra="-mfpu=$GCC_BUILD_FPU $extra"
[ "$GCC_BUILD_FLOAT" != "" ] && extra="-m$GCC_BUILD_FLOAT-float $extra"

CFLAGS="$extra" ../glibc-$VERSION/configure\
    --prefix=$PREFIX_CROSS\
    --host=$ARCH_TARGET\
    --build=$(../glibc-$VERSION/scripts/config.guess)\
    --disable-profile\
    --enable-kernel=2.6.32\
    --with-headers=$PREFIX_CROSS/include\
    libc_cv_forced_unwind=yes\
    libc_cv_ctors_header=yes\
    libc_cv_c_cleanup=yes

make && make install
