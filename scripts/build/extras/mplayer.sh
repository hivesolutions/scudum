VERSION=${VERSION-2014-12-19}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "yasm" "gtk+2" "libvdpau"

wget "http://anduin.linuxfromscratch.org/sources/other/mplayer-$VERSION.tar.xz"
rm -rf mplayer-$VERSION && tar -Jxf "mplayer-$VERSION.tar.xz"
rm -f "mplayer-$VERSION.tar.xz"
cd mplayer-$VERSION

./configure --prefix=$PREFIX --enable-menu --enable-gui --enable-dynamic-plugins
make && make install
