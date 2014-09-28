VERSION=${VERSION-1.1.28}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libxml2"

wget "http://xmlsoft.org/sources/libxslt-$VERSION.tar.gz"
rm -rf libxslt-$VERSION && tar -zxf "libxslt-$VERSION.tar.gz"
rm -f "libxslt-$VERSION.tar.gz"
cd libxslt-$VERSION

./configure --prefix=$PREFIX
make && make install
