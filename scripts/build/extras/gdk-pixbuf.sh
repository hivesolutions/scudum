VERSION=${VERSION-2.30.4}
VERSION_L=${VERSION_L-2.30}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "glib" "libpng" "tiff" "jpeg-turbo"

wget "http://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/$VERSION_L/gdk-pixbuf-$VERSION.tar.xz"
rm -rf gdk-pixbuf-$VERSION && tar -Jxf "gdk-pixbuf-$VERSION.tar.xz"
rm -f "gdk-pixbuf-$VERSION.tar.xz"
cd gdk-pixbuf-$VERSION

./configure --prefix=$PREFIX
make && make install
