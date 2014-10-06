VERSION=${VERSION-1.0.4}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "xorg-applications"

wget "http://xorg.freedesktop.org/archive/individual/data/xcursor-themes-$VERSION.tar.bz2"
rm -rf xcursor-themes-$VERSION && tar -jxf "xcursor-themes-$VERSION.tar.bz2"
rm -f "xcursor-themes-$VERSION.tar.bz2"
cd xcursor-themes-$VERSION

./configure --prefix=$PREFIX
make && make install
