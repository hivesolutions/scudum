VERSION=${VERSION-0.8.5}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libpcap"

wget "https://github.com/raboof/nethogs/archive/v$VERSION.tar.gz"
rm -rf nethogs && tar -zxf "v$VERSION.tar.gz"
rm -f "v$VERSION.tar.gz"
cd nethogs

make && make DESTDIR=$PREFIX install
