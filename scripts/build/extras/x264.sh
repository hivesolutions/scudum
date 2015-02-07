VERSION=${VERSION-20141218-2245-stable}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "yasm"

wget "http://download.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-$VERSION.tar.bz2"
rm -rf x264-snapshot-$VERSION && tar -jxf "x264-snapshot-$VERSION.tar.bz2"
rm -f "x264-snapshot-$VERSION.tar.bz2"
cd x264-snapshot-$VERSION

./configure --prefix=$PREFIX --enable-shared --disable-cli
make && make install
