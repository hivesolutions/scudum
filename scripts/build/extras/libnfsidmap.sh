VERSION=${VERSION-0.26}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://fedorapeople.org/~steved/libnfsidmap/$VERSION/libnfsidmap-$VERSION.tar.bz2"
rm -rf libnfsidmap-$VERSION && tar -jxf "libnfsidmap-$VERSION.tar.bz2"
rm -f "libnfsidmap-$VERSION.tar.bz2"
cd libnfsidmap-$VERSION

./configure --prefix=$PREFIX
make && make install
