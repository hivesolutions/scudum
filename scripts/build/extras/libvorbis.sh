VERSION=${VERSION-1.3.4}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libogg"

wget "http://downloads.xiph.org/releases/vorbis/libvorbis-$VERSION.tar.xz"
rm -rf libvorbis-$VERSION && tar -Jxf "libvorbis-$VERSION.tar.xz"
rm -f "libvorbis-$VERSION.tar.xz"
cd libvorbis-$VERSION

./configure --prefix=$PREFIX --disable-static
make && make install
