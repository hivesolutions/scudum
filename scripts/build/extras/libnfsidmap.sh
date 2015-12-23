VERSION=${VERSION-0.25}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://www.citi.umich.edu/projects/nfsv4/linux/libnfsidmap/libnfsidmap-$VERSION.tar.gz"
rm -rf libnfsidmap-$VERSION && tar -zxf "libnfsidmap-$VERSION.tar.gz"
rm -f "libnfsidmap-$VERSION.tar.gz"
cd libnfsidmap-$VERSION

./configure --prefix=$PREFIX
make && make install
