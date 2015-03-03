VERSION=${VERSION-4.9.2}

set -e +h

if [ "$SCUDUM_CROSS" == "1" ]; then
    if [ -z "$CC" ]; then export CC="gcc"; fi
    if [ -z "$CXX" ]; then export CXX="g++"; fi
    export CC="$CC -fno-exceptions"
    export CXX="$CXX -fno-exceptions"
fi

wget --no-check-certificate "http://ftp.gnu.org/gnu/gcc/gcc-$VERSION/gcc-$VERSION.tar.bz2"
rm -rf gcc-$VERSION && tar -jxf "gcc-$VERSION.tar.bz2"
rm -f "gcc-$VERSION.tar.bz2"
cd gcc-$VERSION

cd ..
rm -rf gcc-build && mkdir gcc-build
cd gcc-build

SED=sed ../gcc-$VERSION/configure\
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
    --with-system-zlib

make
test $TEST && make -k check
make install

ln -sv ../usr/bin/cpp /lib
ln -sv gcc /usr/bin/cc

mkdir -pv /usr/share/gdb/auto-load/usr/lib
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib
