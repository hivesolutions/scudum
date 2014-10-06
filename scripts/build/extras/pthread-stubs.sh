VERSION=${VERSION-0.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://xcb.freedesktop.org/dist/libpthread-stubs-$VERSION.tar.bz2"
rm -rf libpthread-stubs-$VERSION && tar -jxf "libpthread-stubs-$VERSION.tar.bz2"
rm -f "libpthread-stubs-$VERSION.tar.bz2"
cd libpthread-stubs-$VERSION

./configure --prefix=$PREFIX
make && make install
