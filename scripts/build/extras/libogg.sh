VERSION=${VERSION-1.3.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://downloads.xiph.org/releases/ogg/libogg-$VERSION.tar.xz"
rm -rf libogg-$VERSION && tar -Jxf "libogg-$VERSION.tar.xz"
rm -f "libogg-$VERSION.tar.xz"
cd libogg-$VERSION

./configure --prefix=$PREFIX --disable-static
make && make install
