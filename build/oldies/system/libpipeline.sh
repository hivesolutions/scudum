VERSION="1.2.2"
tar -zxf "libpipeline-$VERSION.tar.gz"
cd libpipeline-$VERSION

PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr
make
test $TEST && make check
make install

cd ..
rm -rf libpipeline-$VERSION
