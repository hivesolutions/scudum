VERSION=${VERSION-1.18.2}
VERSION_L=${VERSION_L-1.18}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "gdk-pixbuf" "mesa" "pango"

wget "http://ftp.gnome.org/pub/gnome/sources/cogl/$VERSION_L/cogl-$VERSION.tar.xz"
rm -rf cogl-$VERSION && tar -Jxf "cogl-$VERSION.tar.xz"
rm -f "cogl-$VERSION.tar.xz"
cd cogl-$VERSION

./configure --prefix=$PREFIX --enable-gles1 --enable-gles2
make && make install
