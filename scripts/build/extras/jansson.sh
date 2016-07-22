VERSION=${VERSION-2.7}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://www.digip.org/jansson/releases/jansson-$VERSION.tar.gz"
rm -rf jansson-$VERSION && tar -zxf "jansson-$VERSION.tar.gz"
rm -f "jansson-$VERSION.tar.gz"
cd jansson-$VERSION

./configure --prefix=$PREFIX
make && make install
