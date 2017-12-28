VERSION=${VERSION-2.55.0}
VERSION_L=${VERSION_L-2.55}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libffi" "python" "pcre"

wget "http://ftp.gnome.org/pub/gnome/sources/glib/$VERSION_L/glib-$VERSION.tar.xz"
rm -rf glib-$VERSION && tar -Jxf "glib-$VERSION.tar.xz"
rm -f "glib-$VERSION.tar.xz"
cd glib-$VERSION

./configure --prefix=$PREFIX --with-pcre=system
make && make install
