VERSION=${VERSION-1.15.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "pixman" "libdrm" "dbus" "mesa" "xkeyboard-config" "xorg-applications" "xorg-fonts" "xterm" "xclock" "twm" "xinit"

wget "http://xorg.freedesktop.org/archive/individual/xserver/xorg-server-$VERSION.tar.bz2"
rm -rf xorg-server-$VERSION && tar -jxf "xorg-server-$VERSION.tar.bz2"
rm -f "xorg-server-$VERSION.tar.bz2"
cd xorg-server-$VERSION

./configure\
    --prefix=$PREFIX\
    --with-fontrootdir=$PREFIX/share/fonts/X11\
    --sysconfdir=/etc\
    --localstatedir=/var\
    --with-xkb-output=/var/lib/xkb\
    --enable-dmx\
    --enable-install-setuid

make && make install
