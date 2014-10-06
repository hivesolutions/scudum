VERSION=${VERSION-1.8.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "expat"

wget "http://dbus.freedesktop.org/releases/dbus/dbus-$VERSION.tar.gz"
rm -rf dbus-$VERSION && tar -zxf "dbus-$VERSION.tar.gz"
rm -f "dbus-$VERSION.tar.gz"
cd dbus-$VERSION

./configure\
    --prefix=$PREFIX\
    --sysconfdir=/etc\
    --localstatedir=/var\
    --with-console-auth-dir=/run/console/\
    --without-systemdsystemunitdir\
    --disable-systemd\
    --disable-static

make && make install
