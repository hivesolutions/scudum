VERSION=${VERSION-4.24}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget --content-disposition "http://dist.schmorp.de/libev/Attic/libev-$VERSION.tar.gz"
rm -rf libev-$VERSION && tar -zxf "libev-$VERSION.tar.gz"
rm -f "libev-$VERSION.tar.gz"
cd libev-$VERSION

./configure --prefix=$PREFIX
make && make install
