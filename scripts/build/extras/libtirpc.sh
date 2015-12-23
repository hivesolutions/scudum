VERSION=${VERSION-0.3.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://downloads.sourceforge.net/libtirpc/libtirpc-$VERSION.tar.bz2"
rm -rf libtirpc-$VERSION && tar -jxf "libtirpc-$VERSION.tar.bz2"
rm -f "libtirpc-$VERSION.tar.bz2"
cd libtirpc-$VERSION

./configure --prefix=$PREFIX --disable-static --disable-gssapi
make && make install
