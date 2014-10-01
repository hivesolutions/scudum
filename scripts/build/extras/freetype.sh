VERSION=${VERSION-2.5.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

requires "libpng"

wget "http://download.savannah.gnu.org/releases/freetype/freetype-$VERSION.tar.gz"
rm -rf freetype-$VERSION && tar -zxf "freetype-$VERSION.tar.gz"
rm -f "freetype-$VERSION.tar.gz"
cd freetype-$VERSION

./configure --prefix=$PREFIX
make && make install
