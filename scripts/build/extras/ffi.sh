VERSION=${VERSION-3.2.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "ftp://sourceware.org/pub/libffi/libffi-$VERSION.tar.gz"
rm -rf libffi-$VERSION && tar -zxf "libffi-$VERSION.tar.gz"
rm -f "libffi-$VERSION.tar.gz"
cd libffi-$VERSION

./configure --prefix=$PREFIX --disable-static
make && make install
