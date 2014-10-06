VERSION=${VERSION-2.4.52}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "xorg-libs"

wget "http://dri.freedesktop.org/libdrm/libdrm-$VERSION.tar.bz2"
rm -rf libdrm-$VERSION && tar -jxf "libdrm-$VERSION.tar.bz2"
rm -f "libdrm-$VERSION.tar.bz2"
cd libdrm-$VERSION

./configure --prefix=$PREFIX
make && make install
