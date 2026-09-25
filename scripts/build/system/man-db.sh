VERSION=${VERSION-2.13.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/man-db/$VERSION/man-db-$VERSION.tar.xz"\
    "https://download.savannah.gnu.org/releases/man-db/man-db-$VERSION.tar.xz"
rm -rf man-db-$VERSION && tar -Jxf "man-db-$VERSION.tar.xz"
rm -f "man-db-$VERSION.tar.xz"
cd man-db-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --docdir=/usr/share/doc/man-db-$VERSION\
    --sysconfdir=/etc\
    --disable-setuid\
    --enable-cache-owner=bin\
    --with-browser=/usr/bin/lynx\
    --with-vgrind=/usr/bin/vgrind\
    --with-grap=/usr/bin/grap

make
test $TEST && make check
make install
