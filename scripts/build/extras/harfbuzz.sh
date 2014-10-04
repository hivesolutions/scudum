VERSION=${VERSION-0.9.35}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "cairo" "freetype"

wget "http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-$VERSION.tar.bz2"
rm -rf harfbuzz-$VERSION && tar -jxf "harfbuzz-$VERSION.tar.bz2"
rm -f "harfbuzz-$VERSION.tar.bz2"
cd harfbuzz-$VERSION

./configure --prefix=$PREFIX
make && make install
