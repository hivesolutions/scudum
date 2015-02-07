VERSION=${VERSION-0.9}
VERSION_GL=${VERSION_GL-0.3.4}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "xorg-libs" "mesa"

wget "http://people.freedesktop.org/~aplattner/vdpau/libvdpau-$VERSION.tar.gz"
rm -rf libvdpau-$VERSION && tar -zxf "libvdpau-$VERSION.tar.gz"
rm -f "libvdpau-$VERSION.tar.gz"
cd libvdpau-$VERSION

./configure --prefix=$PREFIX
make && make install
