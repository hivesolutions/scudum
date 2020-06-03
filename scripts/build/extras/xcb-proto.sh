VERSION=${VERSION-1.11}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "python"

wget --content-disposition "http://xcb.freedesktop.org/dist/xcb-proto-$VERSION.tar.bz2"
rm -rf xcb-proto-$VERSION && tar -jxf "xcb-proto-$VERSION.tar.bz2"
rm -f "xcb-proto-$VERSION.tar.bz2"
cd xcb-proto-$VERSION

./configure --prefix=$PREFIX --sysconfdir=/etc
make && make install
