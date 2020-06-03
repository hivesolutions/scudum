VERSION=${VERSION-0.19.6}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "glib"

wget --content-disposition "http://fribidi.org/download/fribidi-$VERSION.tar.bz2"
rm -rf fribidi-$VERSION && tar -jxf "fribidi-$VERSION.tar.bz2"
rm -f "fribidi-$VERSION.tar.bz2"
cd fribidi-$VERSION

./configure --prefix=$PREFIX
make && make install
