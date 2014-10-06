VERSION=${VERSION-1.1.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://xorg.freedesktop.org/archive/individual/data/xbitmaps-$VERSION.tar.bz2"
rm -rf xbitmaps-$VERSION && tar -jxf "xbitmaps-$VERSION.tar.bz2"
rm -f "xbitmaps-$VERSION.tar.bz2"
cd xbitmaps-$VERSION

./configure --prefix=$PREFIX
make && make install
