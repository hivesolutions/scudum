VERSION=${VERSION-2.9.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libpng"

rget "http://netcologne.dl.sourceforge.net/project/freetype/freetype-$VERSION.tar.gz"\
    "http://download.savannah.gnu.org/releases/freetype/freetype-$VERSION.tar.gz"\
    "http://mirrors.zerg.biz/nongnu/freetype/freetype-$VERSION.tar.gz"
rm -rf freetype-$VERSION && tar -zxf "freetype-$VERSION.tar.gz"
rm -f "freetype-$VERSION.tar.gz"
cd freetype-$VERSION

./configure --prefix=$PREFIX
make && make install
