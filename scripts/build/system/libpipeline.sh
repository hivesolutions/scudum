VERSION=${VERSION-1.5.0}

set -e +h

wget --no-check-certificate "http://download.savannah.gnu.org/releases/libpipeline/libpipeline-$VERSION.tar.gz"
rm -rf libpipeline-$VERSION && tar -zxf "libpipeline-$VERSION.tar.gz"
rm -f "libpipeline-$VERSION.tar.gz"
cd libpipeline-$VERSION

PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --host=$ARCH_TARGET --prefix=/usr

make
test $TEST && make check
make install
