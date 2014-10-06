VERSION=${VERSION-1.15.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "pixman" "libdrm" "dbus"

wget "http://xorg.freedesktop.org/archive/individual/xserver/xorg-server-$VERSION.tar.bz2"
rm -rf xorg-server-$VERSION && tar -jxf "xorg-server-$VERSION.tar.bz2"
rm -f "xorg-server-$VERSION.tar.bz2"
cd xorg-server-$VERSION

./configure --prefix=$PREFIX
make && make install
