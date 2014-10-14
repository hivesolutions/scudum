VERSION=${VERSION-2.4.0}
VERSION_L=${VERSION_L-2.4}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://ftp.gnome.org/pub/gnome/sources/libsigc++/$VERSION_L/libsigc++-$VERSION.tar.xz"
rm -rf libsigc++-$VERSION && tar -Jxf "libsigc++-$VERSION.tar.xz"
rm -f "libsigc++-$VERSION.tar.xz"
cd libsigc++-$VERSION

./configure --prefix=$PREFIX
make && make install
