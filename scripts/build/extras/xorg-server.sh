VERSION=${VERSION-1.15.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "pixman" "libdrm" "dbus" "mesa" "xkeyboard-config" "xorg-applications"

wget "http://xorg.freedesktop.org/archive/individual/xserver/xorg-server-$VERSION.tar.bz2"
rm -rf xorg-server-$VERSION && tar -jxf "xorg-server-$VERSION.tar.bz2"
rm -f "xorg-server-$VERSION.tar.bz2"
cd xorg-server-$VERSION

./configure\
    --prefix=$PREFIX\
    --with-xkb-output=/var/lib/xkb\
    --enable-dmx\
    --enable-glamor\
    --enable-install-setuid\
    --enable-suid-wrapper

make && make install
