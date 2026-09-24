VERSION=${VERSION-1.19}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "https://mirrors.hive.pt/mirrors/scudum/popt/$VERSION/popt-$VERSION.tar.gz"\
    "https://ftp.osuosl.org/pub/rpm/popt/releases/popt-1.x/popt-$VERSION.tar.gz"\
    "https://ftp.osuosl.org/pub/blfs/conglomeration/popt/popt-$VERSION.tar.gz"
rm -rf popt-$VERSION && tar -zxf "popt-$VERSION.tar.gz"
rm -f "popt-$VERSION.tar.gz"
cd popt-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX
make && make install
