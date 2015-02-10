VERSION=${VERSION-0.4.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libxcb"

wget "http://xcb.freedesktop.org/dist/xcb-util-keysyms-$VERSION.tar.bz2"
rm -rf xcb-util-keysyms-$VERSION && tar -jxf "xcb-util-keysyms-$VERSION.tar.bz2"
rm -f "xcb-util-keysyms-$VERSION.tar.bz2"
cd xcb-util-keysyms-$VERSION

./configure --prefix=$PREFIX
make && make install
