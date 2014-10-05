VERSION=${VERSION-2.10.93}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "freetype" "libxml2"

wget "http://www.freedesktop.org/software/fontconfig/release/fontconfig-$VERSION.tar.bz2"
rm -rf fontconfig-$VERSION && tar -jxf "fontconfig-$VERSION.tar.bz2"
rm -f "fontconfig-$VERSION.tar.bz2"
cd fontconfig-$VERSION

./configure --prefix=$PREFIX --enable-libxml2
make && make install
