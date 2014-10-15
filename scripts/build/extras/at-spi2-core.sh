VERSION=${VERSION-2.14.0}
VERSION_L=${VERSION_L-2.14}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "dbus" "glib" "xorg-libs"

wget "http://ftp.gnome.org/pub/gnome/sources/at-spi2-core/$VERSION_L/at-spi2-core-$VERSION.tar.xz"
rm -rf at-spi2-core-$VERSION && tar -Jxf "at-spi2-core-$VERSION.tar.xz"
rm -f "at-spi2-core-$VERSION.tar.xz"
cd at-spi2-core-$VERSION

./configure --prefix=$PREFIX --sysconfdir=/etc
make && make install
