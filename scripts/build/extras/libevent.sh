VERSION=${VERSION-2.0.21}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://github.com/downloads/libevent/libevent/libevent-$VERSION-stable.tar.gz"
rm -rf libevent-$VERSION-stable && tar -zxf "libevent-$VERSION-stable.tar.gz"
rm -f "libevent-$VERSION-stable.tar.gz"
cd libevent-$VERSION-stable

./configure --prefix=$PREFIX --disable-static
make && make install
