VERSION=${VERSION-1.03}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://www.oberhumer.com/opensource/ucl/download/ucl-$VERSION.tar.gz"
rm -rf ucl-$VERSION && tar -zxf "ucl-$VERSION.tar.gz"
rm -f "ucl-$VERSION.tar.gz"
cd ucl-$VERSION

./configure --prefix=$PREFIX
make && make install
