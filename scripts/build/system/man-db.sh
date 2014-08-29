VERSION=${VERSION-2.6.3}

set -e +h

wget --no-check-certificate "http://download.savannah.gnu.org/releases/man-db/man-db-$VERSION.tar.xz"
rm -rf man-db-$VERSION && tar -Jxf "man-db-$VERSION.tar.xz"
rm -f "man-db-$VERSION.tar.xz"
cd man-db-$VERSION

./configure\
    --prefix=/usr\
    --libexecdir=/usr/lib\
    --docdir=/usr/share/doc/man-db-$VERSION\
    --sysconfdir=/etc\
    --disable-setuid\
    --with-browser=/usr/bin/lynx\
    --with-vgrind=/usr/bin/vgrind\
    --with-grap=/usr/bin/grap

make
test $TEST && make check
make install
