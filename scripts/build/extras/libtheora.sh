VERSION=${VERSION-1.1.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libogg"

wget "http://downloads.xiph.org/releases/theora/libtheora-$VERSION.tar.xz"
rm -rf libtheora-$VERSION && tar -Jxf "libtheora-$VERSION.tar.xz"
rm -f "libtheora-$VERSION.tar.xz"
cd libtheora-$VERSION

sed -i 's/png_\(sizeof\)/\1/g' examples/png2theora.c &&
./configure --prefix=$PREFIX --disable-static
make && make install
