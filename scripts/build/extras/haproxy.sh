VERSION=${VERSION-1.8.13}
VERSION_L=${VERSION_L-1.8}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://www.haproxy.org/download/$VERSION_L/src/haproxy-$VERSION.tar.gz"
rm -rf haproxy-$VERSION && tar -zxf "haproxy-$VERSION.tar.gz"
rm -f "haproxy-$VERSION.tar.gz"
cd haproxy-$VERSION

make TARGET=generic && make install PREFIX=$PREFIX
