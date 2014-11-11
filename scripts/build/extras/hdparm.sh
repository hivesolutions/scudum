VERSION=${VERSION-9.45}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://downloads.sourceforge.net/hdparm/hdparm-$VERSION.tar.gz"
rm -rf hdparm-$VERSION && tar -zxf "hdparm-$VERSION.tar.gz"
rm -f "hdparm-$VERSION.tar.gz"
cd hdparm-$VERSION

make && make install binprefix=$PREFIX manprefix=$PREFIX
