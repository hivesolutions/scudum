VERSION=${VERSION-1.0.7}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "xorg-applications"

wget "http://xorg.freedesktop.org/releases/individual/app/xclock-$VERSION.tar.bz2"
rm -rf xclock-$VERSION && tar -jxf "xclock-$VERSION.tar.bz2"
rm -f "xclock-$VERSION.tar.bz2"
cd xclock-$VERSION

./configure --prefix=$PREFIX
make && make install
