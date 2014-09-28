VERSION=${VERSION-0.8.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libpcap"

wget "http://prdownloads.sourceforge.net/nethogs/nethogs-$VERSION.tar.gz"
rm -rf nethogs && tar -zxf "nethogs-$VERSION.tar.gz"
rm -f "nethogs-$VERSION.tar.gz"
cd nethogs

make && make DESTDIR=$PREFIX install
