VERSION=${VERSION-2.14.1}
VERSION_L=${VERSION_L-2.14}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "at-spi2-core" "atk"

wget "http://ftp.gnome.org/pub/gnome/sources/at-spi2-atk/$VERSION_L/at-spi2-atk-$VERSION.tar.xz"
rm -rf at-spi2-atk-$VERSION && tar -Jxf "at-spi2-atk-$VERSION.tar.xz"
rm -f "at-spi2-atk-$VERSION.tar.xz"
cd at-spi2-atk-$VERSION

./configure --prefix=$PREFIX
make && make install
