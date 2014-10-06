VERSION=${VERSION-1.0.8}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "xorg-applications"

wget "http://xorg.freedesktop.org/releases/individual/app/twm-$VERSION.tar.bz2"
rm -rf twm-$VERSION && tar -jxf "twm-$VERSION.tar.bz2"
rm -f "twm-$VERSION.tar.bz2"
cd twm-$VERSION

./configure --prefix=$PREFIX
make && make install
