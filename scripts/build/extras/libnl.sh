VERSION=${VERSION-3.2.25}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://www.carisma.slowglass.com/~tgr/libnl/files/libnl-$VERSION.tar.gz"
rm -rf libnl-$VERSION && tar -zxf "libnl-$VERSION.tar.gz"
rm -f "libnl-$VERSION.tar.gz"
cd libnl-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=$PREFIX\
    --sysconfdir=/etc\
    --disable-static

make && make install
