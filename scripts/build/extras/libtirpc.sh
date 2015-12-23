VERSION=${VERSION-1.0.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.s

wget "http://downloads.sourceforge.net/libtirpc/libtirpc-$VERSION.tar.gz"
rm -rf libtirpc-$VERSION && tar -zxf "libtirpc-$VERSION.tar.gz"
rm -f "libtirpc-$VERSION.tar.gz"
cd libtirpc-$VERSION

./configure --prefix=$PREFIX
make && make install
