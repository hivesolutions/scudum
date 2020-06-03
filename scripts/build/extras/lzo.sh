VERSION=${VERSION-2.08}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget --content-disposition "http://www.oberhumer.com/opensource/lzo/download/lzo-$VERSION.tar.gz"
rm -rf lzo-$VERSION && tar -zxf "lzo-$VERSION.tar.gz"
rm -f "lzo-$VERSION.tar.gz"
cd lzo-$VERSION

./configure --prefix=$PREFIX --enable-shared --disable-static
make && make install
