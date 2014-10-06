VERSION=${VERSION-B.02.17}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://www.ezix.org/software/files/lshw-$VERSION.tar.gz"
rm -rf lshw-$VERSION && tar -zxf "lshw-$VERSION.tar.gz"
rm -f "lshw-$VERSION.tar.gz"
cd lshw-$VERSION

make && make install PREFIX=$PREFIX
