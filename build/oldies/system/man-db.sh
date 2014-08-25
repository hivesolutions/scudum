VERSION="2.6.3"
tar -Jxf "man-db-$VERSION.tar.xz"
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

cd ..
rm -rf man-db-$VERSION
