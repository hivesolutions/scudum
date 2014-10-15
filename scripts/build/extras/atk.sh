VERSION=${VERSION-2.14.0}
VERSION_L=${VERSION_L-2.14}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "glib"

wget "http://ftp.gnome.org/pub/gnome/sources/atk/$VERSION_L/atk-$VERSION.tar.xz"
rm -rf atk-$VERSION && tar -Jxf "atk-$VERSION.tar.xz"
rm -f "atk-$VERSION.tar.xz"
cd atk-$VERSION

./configure --prefix=$PREFIX
make && make install
