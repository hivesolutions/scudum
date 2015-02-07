VERSION=${VERSION-2.84}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libevent" "gtk+3"

wget "https://transmission.cachefly.net/transmission-$VERSION.tar.xz"
rm -rf transmission-$VERSION && tar -Jxf "transmission-$VERSION.tar.xz"
rm -f "transmission-$VERSION.tar.xz"
cd transmission-$VERSION

./configure --prefix=$PREFIX
make && make install
