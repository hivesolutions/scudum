VERSION=${VERSION-0.102}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "dbus" "glib"

wget "http://dbus.freedesktop.org/releases/dbus-glib/dbus-glib-$VERSION.tar.gz"
rm -rf dbus-glib-$VERSION && tar -zxf "dbus-glib-$VERSION.tar.gz"
rm -f "dbus-glib-$VERSION.tar.gz"
cd dbus-glib-$VERSION

./configure\
    --prefix=$PREFIX\
    --sysconfdir=/etc\
    --disable-static

make && make install
