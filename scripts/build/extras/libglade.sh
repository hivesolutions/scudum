VERSION=${VERSION-2.6.4}
VERSION_L=${VERSION_L-2.6}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://ftp.gnome.org/pub/gnome/sources/libglade/$VERSION_L/libglade-$VERSION.tar.bz2"
rm -rf libglade-$VERSION && tar -jxf "libglade-$VERSION.tar.bz2"
rm -f "libglade-$VERSION.tar.bz2"
cd libglade-$VERSION

./configure --prefix=$PREFIX --disable-static
make && make install
