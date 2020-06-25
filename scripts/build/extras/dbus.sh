VERSION=${VERSION-1.13.16}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "expat"

wget --content-disposition "http://dbus.freedesktop.org/releases/dbus/dbus-$VERSION.tar.xz"
rm -rf dbus-$VERSION && tar -Jxf "dbus-$VERSION.tar.xz"
rm -f "dbus-$VERSION.tar.xz"
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

dbus-uuidgen > /etc/machine-id
dbus-uuidgen --ensure
