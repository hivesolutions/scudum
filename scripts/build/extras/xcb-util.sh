VERSION=${VERSION-0.3.9}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libxcb"

wget "http://xcb.freedesktop.org/dist/xcb-util-$VERSION.tar.bz2"
rm -rf xcb-util-$VERSION && tar -jxf "xcb-util-$VERSION.tar.bz2"
rm -f "xcb-util-$VERSION.tar.bz2"
cd xcb-util-$VERSION

./configure --prefix=$PREFIX
make && make install
