VERSION=${VERSION-16.2.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/gcc/$VERSION/gcc-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/gcc/gcc-$VERSION/gcc-$VERSION.tar.xz"
rm -rf gcc-$VERSION && tar -Jxf "gcc-$VERSION.tar.xz"
rm -f "gcc-$VERSION.tar.xz"
cd gcc-$VERSION

case $SCUDUM_ARCH in
    x86_64)
        sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
    ;;
esac

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
    --prefix=/usr\
    LD=ld\
    --enable-languages=c,c++\
    --enable-default-pie\
    --enable-default-ssp\
    --enable-host-pie\
    --enable-targets=all\
    --disable-multilib\
    --disable-bootstrap\
    --disable-fixincludes\
    --with-system-zlib\
    $extra

make
test $TEST && make -k check
make install

ln -svfr /usr/bin/cpp /usr/lib
ln -svf gcc /usr/bin/cc
ln -svf gcc.1 /usr/share/man/man1/cc.1

install -v -dm755 /usr/lib/bfd-plugins
ln -sfv ../../libexec/gcc/$ARCH_TARGET/$VERSION/liblto_plugin.so /usr/lib/bfd-plugins/liblto_plugin.so

echo "int main(){}" > dummy.c && cc dummy.c -v -Wl,--verbose &> dummy.log
readelf -l a.out | grep ": /lib" && ./a.out && rm -v dummy.c a.out

mkdir -pv /usr/share/gdb/auto-load/usr/lib
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib
