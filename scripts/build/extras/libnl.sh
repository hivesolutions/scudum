VERSION=${VERSION-3.12.0}
VERSION_L=${VERSION_L-3_12_0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "https://mirrors.hive.pt/mirrors/scudum/libnl/$VERSION/libnl-$VERSION.tar.gz"\
    "https://github.com/thom311/libnl/releases/download/libnl$VERSION_L/libnl-$VERSION.tar.gz"
rm -rf libnl-$VERSION && tar -zxf "libnl-$VERSION.tar.gz"
rm -f "libnl-$VERSION.tar.gz"
cd libnl-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=$PREFIX\
    --sysconfdir=/etc\
    --disable-static

make && make install
