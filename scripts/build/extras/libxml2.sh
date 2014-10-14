VERSION=${VERSION-2.9.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://xmlsoft.org/sources/libxml2-$VERSION.tar.gz"
rm -rf libxml2-$VERSION && tar -zxf "libxml2-$VERSION.tar.gz"
rm -f "libxml2-$VERSION.tar.gz"
cd libxml2-$VERSION

./configure --prefix=$PREFIX --disable-static --with-history
make && make install
