VERSION="0.28"
tar -zxf "pkg-config-$VERSION.tar.gz"
cd pkg-config-$VERSION

./configure\
    --prefix=/usr\
    --with-internal-glib\
    --disable-host-tool\
    --docdir=/usr/share/doc/pkg-config-$VERSION
make
make check
make install

cd ..
rm -rf pkg-config-$VERSION
