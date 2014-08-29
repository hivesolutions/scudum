VERSION=${VERSION-1.6.1}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget --no-check-certificate "http://www.tcpdump.org/release/libpcap-$VERSION.tar.gz"
rm -rf "libpcap-$VERSION" && tar -zxf "libpcap-$VERSION.tar.gz"
rm -f "libpcap-$VERSION.tar.gz"
cd libpcap-$VERSION

./configure --prefix=$PREFIX
make && make install
