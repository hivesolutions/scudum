VERSION=${VERSION-1.16}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "http://ftp.rpm.org/mirror/popt/popt-$VERSION.tar.gz"\
    "http://rpm5.org/files/popt/popt-$VERSION.tar.gz"\
    "https://ftp.osuosl.org/pub/blfs/conglomeration/popt/popt-$VERSION.tar.gz"
rm -rf popt-$VERSION && tar -zxf "popt-$VERSION.tar.gz"
rm -f "popt-$VERSION.tar.gz"
cd popt-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX
make && make install
