VERSION=${VERSION-0.28}

set -e +h

wget --no-check-certificate "http://pkgconfig.freedesktop.org/releases/pkg-config-$VERSION.tar.gz"
rm -rf pkg-config-$VERSION && tar -zxf "pkg-config-$VERSION.tar.gz"
rm -f "pkg-config-$VERSION.tar.gz"
cd pkg-config-$VERSION

sed -i 's/as_fn_error ()/as_fn_error ()\n{\nreturn 0\n}\nold_as_fn_error ()\n/' glib/configure

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --with-internal-glib\
    --disable-host-tool\
    --docdir=/usr/share/doc/pkg-config-$VERSION

make
test $TEST && make check
make install
