VERSION=${VERSION-4.9.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://www.tcpdump.org/release/libpcap-$VERSION.tar.gz"
rm -rf libpcap-$VERSION && tar -zxf "libpcap-$VERSION.tar.gz"
rm -f "libpcap-$VERSION.tar.gz"
cd libpcap-$VERSION

./configure --prefix=$PREFIX
make && make install
