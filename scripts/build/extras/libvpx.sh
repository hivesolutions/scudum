VERSION=${VERSION-1.3.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "yasm"

wget "http://anduin.linuxfromscratch.org/sources/other/libvpx-v$VERSION.tar.xz"
rm -rf libvpx-v$VERSION && tar -Jxf "libvpx-v$VERSION.tar.xz"
rm -f "libvpx-v$VERSION.tar.xz"
cd libvpx-v$VERSION

./configure --prefix=$PREFIX --enable-shared --disable-static
make && make install
