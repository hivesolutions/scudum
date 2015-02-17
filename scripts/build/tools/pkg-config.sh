VERSION=${VERSION-0.28}

set -e +h

wget "http://pkgconfig.freedesktop.org/releases/pkg-config-$VERSION.tar.gz"
rm -rf pkg-config-$VERSION && tar -zxf "pkg-config-$VERSION.tar.gz"
rm -f "pkg-config-$VERSION.tar.gz"
cd pkg-config-$VERSION

./configure\
    --prefix=$PREFIX
    --with-internal-glib\
    --disable-host-tool\
    --docdir=$PREFIX/share/doc/pkg-config-$VERSION

make && make install
