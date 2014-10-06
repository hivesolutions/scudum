VERSION=${VERSION-3.10.7}
VERSION_L=${VERSION_L-3.10}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "pango" "atk" "gdk-pixbuf"

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
