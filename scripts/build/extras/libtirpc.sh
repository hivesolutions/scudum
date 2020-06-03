VERSION=${VERSION-1.0.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget --content-disposition "http://downloads.sourceforge.net/libtirpc/libtirpc-$VERSION.tar.bz2?use_mirror=ayera"
rm -rf libtirpc-$VERSION && tar -jxf "libtirpc-$VERSION.tar.bz2"
rm -f "libtirpc-$VERSION.tar.bz2"
cd libtirpc-$VERSION

./configure --prefix=$PREFIX --sysconfdir=/etc --disable-static --disable-gssapi
make && make install
