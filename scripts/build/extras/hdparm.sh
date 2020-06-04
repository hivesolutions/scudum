VERSION=${VERSION-9.45}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget --content-disposition "http://downloads.sourceforge.net/hdparm/hdparm-$VERSION.tar.gz?use_mirror=netix"
rm -rf hdparm-$VERSION && tar -zxf "hdparm-$VERSION.tar.gz"
rm -f "hdparm-$VERSION.tar.gz"
cd hdparm-$VERSION

make && make install binprefix=$PREFIX manprefix=$PREFIX
