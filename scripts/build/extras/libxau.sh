VERSION=${VERSION-1.0.8}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://xorg.freedesktop.org/releases/individual/lib/libXau-$VERSION.tar.bz2"
rm -rf libXau-$VERSION && tar -jxf "libXau-$VERSION.tar.bz2"
rm -f "libXau-$VERSION.tar.bz2"
cd libXau-$VERSION

./configure --prefix=$PREFIX --sysconfdir=/etc --disable-static
make && make install
