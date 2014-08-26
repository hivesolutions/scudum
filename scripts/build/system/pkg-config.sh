VERSION=${VERSION-0.28}

wget "http://pkgconfig.freedesktop.org/releases/pkg-config-$VERSION.tar.gz"
rm -rf pkg-config-$VERSION && tar -zxf "pkg-config-$VERSION.tar.gz"
rm -f "pkg-config-$VERSION.tar.gz"
cd pkg-config-$VERSION

./configure\
    --prefix=/usr\
    --with-internal-glib\
    --disable-host-tool\
    --docdir=/usr/share/doc/pkg-config-$VERSION

make
make check
make install
