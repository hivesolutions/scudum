VERSION=${VERSION-3.99.5}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "nasm"

rget "http://downloads.sourceforge.net/lame/lame-$VERSION.tar.gz"\
    "http://fossies.org/linux/misc/lame-$VERSION.tar.gz"
rm -rf lame-$VERSION && tar -zxf "lame-$VERSION.tar.gz"
rm -f "lame-$VERSION.tar.gz"
cd lame-$VERSION

./configure --prefix=$PREFIX --enable-mp3rtp --disable-static
make && make install
