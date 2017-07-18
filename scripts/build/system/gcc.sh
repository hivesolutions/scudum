VERSION=${VERSION-4.8.5}

set -e +h

if [ "$SCUDUM_CROSS" == "1" ]; then
    if [ -z "$CFLAGS" ]; then export CFLAGS="-O2"; fi
    if [ -z "$CXXFLAGS" ]; then export CXXFLAGS="-O2"; fi
    export CFLAGS="$CFLAGS -fno-exceptions"
    export CXXFLAGS="$CXXFLAGS -fno-exceptions"
fi

wget --no-check-certificate "http://ftp.gnu.org/gnu/gcc/gcc-$VERSION/gcc-$VERSION.tar.gz"
rm -rf gcc-$VERSION && tar -zxf "gcc-$VERSION.tar.gz"
rm -f "gcc-$VERSION.tar.gz"
cd gcc-$VERSION

case $SCUDUM_ARCH in
    i?86) sed -i 's/^T_CFLAGS =$/& -fomit-frame-pointer/' gcc/Makefile.in ;;
esac

sed -i -e /autogen/d -e /check.sh/d fixincludes/Makefile.in

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
    --host=$ARCH_TARGET\
    --target=$ARCH_TARGET\
    --program-prefix=\
    --prefix=/usr\
    --libexecdir=/usr/lib\
    --enable-shared\
    --enable-threads=posix\
    --enable-__cxa_atexit\
    --enable-clocale=gnu\
    --enable-languages=c,c++\
    --disable-multilib\
    --disable-bootstrap\
    --with-system-zlib\
    $extra

make
test $TEST && make -k check
make install

ln -svf ../usr/bin/cpp /lib
ln -svf gcc /usr/bin/cc

mkdir -pv /usr/share/gdb/auto-load/usr/lib
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib
