VERSION=${VERSION-3.14.3}
VERSION_L=${VERSION_L-3.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "at-spi2-atk" "gdk-pixbuf" "pango"

wget "http://ftp.gnome.org/pub/gnome/sources/gtk+/$VERSION_L/gtk+-$VERSION.tar.xz"
rm -rf gtk+-$VERSION && tar -Jxf "gtk+-$VERSION.tar.xz"
rm -f "gtk+-$VERSION.tar.xz"
cd gtk+-$VERSION

./configure\
    --prefix=$PREFIX\
    --sysconfdir=/etc\
    --enable-broadway-backend\
    --enable-x11-backend\
    --disable-wayland-backend

make && make install
