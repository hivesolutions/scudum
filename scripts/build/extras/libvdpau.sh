VERSION=${VERSION-1.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "xorg-libs"

wget --content-disposition "http://people.freedesktop.org/~aplattner/vdpau/libvdpau-$VERSION.tar.gz"
rm -rf libvdpau-$VERSION && tar -zxf "libvdpau-$VERSION.tar.gz"
rm -f "libvdpau-$VERSION.tar.gz"
cd libvdpau-$VERSION

./configure --prefix=$PREFIX
make && make install
