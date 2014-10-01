VERSION=${VERSION-1.6.13}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://prdownloads.sourceforge.net/libpng/libpng-$VERSION.tar.gz"
rm -rf libpng-$VERSION && tar -zxf "libpng-$VERSION.tar.gz"
rm -f "libpng-$VERSION.tar.gz"
cd libpng-$VERSION

./configure --prefix=$PREFIX
make && make install
