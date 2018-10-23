VERSION=${VERSION-8.2.0}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/gcc/gcc-$VERSION/gcc-$VERSION.tar.gz"
rm -rf gcc-$VERSION && tar -zxf "gcc-$VERSION.tar.gz"
rm -f "gcc-$VERSION.tar.gz"
cd gcc-$VERSION

cd ..
rm -rf gcc-build && mkdir gcc-build
cd gcc-build

extra=""
[ "$GCC_BUILD_ARCH" != "" ] && extra="--with-arch=$GCC_BUILD_ARCH $extra" || true
[ "$GCC_BUILD_CPU" != "" ] && extra="--with-cpu=$GCC_BUILD_CPU $extra" || true
[ "$GCC_BUILD_TUNE" != "" ] && extra="--with-tune=$GCC_BUILD_TUNE $extra" || true
[ "$GCC_BUILD_FPU" != "" ] && extra="--with-fpu=$GCC_BUILD_FPU $extra" || true
[ "$GCC_BUILD_FLOAT" != "" ] && extra="--with-float=$GCC_BUILD_FLOAT $extra" || true

SED=sed ../gcc-$VERSION/configure\
    --host=$ARCH_TARGET\
    --target=$ARCH_TARGET\
    --prefix=/usr\
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

install -v -dm755 /usr/lib/bfd-plugins
ln -sfv ../../libexec/gcc/$ARCH_TARGET/$VERSION/liblto_plugin.so /usr/lib/bfd-plugins/liblto_plugin.so

echo "int main(){}" > dummy.c && cc dummy.c -v -Wl,--verbose &> dummy.log
readelf -l a.out | grep ": /lib" && ./a.out && rm -v dummy.c a.out

mkdir -pv /usr/share/gdb/auto-load/usr/lib
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib
