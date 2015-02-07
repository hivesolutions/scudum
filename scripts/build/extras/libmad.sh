VERSION=${VERSION-0.15.1b}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "http://downloads.sourceforge.net/mad/libmad-$VERSION.tar.gz"
rm -rf libmad-$VERSION && tar -zxf "libmad-$VERSION.tar.gz"
rm -f "libmad-$VERSION.tar.gz"
cd libmad-$VERSION

./configure --prefix=$PREFIX --disable-static
make && make install
