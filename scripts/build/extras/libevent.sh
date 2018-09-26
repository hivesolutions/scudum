VERSION=${VERSION-2.1.8}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://github.com/libevent/libevent/releases/download/release-$VERSION-stable/libevent-$VERSION-stable.tar.gz"
rm -rf libevent-$VERSION-stable && tar -zxf "libevent-$VERSION-stable.tar.gz"
rm -f "libevent-$VERSION-stable.tar.gz"
cd libevent-$VERSION-stable

./configure --prefix=$PREFIX --disable-static
make && make install
