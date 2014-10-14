VERSION=${VERSION-1.4.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "mesa"

wget "http://www.freedesktop.org/software/vaapi/releases/libva/libva-$VERSION.tar.bz2"
rm -rf libva-$VERSION && tar -jxf "libva-$VERSION.tar.bz2"
rm -f "libva-$VERSION.tar.bz2"
cd libva-$VERSION

./configure --prefix=$PREFIX --disable-wayland
make && make install
