VERSION=${VERSION-4.10.1}
VERSION_L=${VERSION_L-4.10}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "glib"

wget "http://archive.xfce.org/src/xfce/libxfce4util/$VERSION_L/libxfce4util-$VERSION.tar.bz2"
rm -rf libxfce4util-$VERSION && tar -jxf "libxfce4util-$VERSION.tar.bz2"
rm -f "libxfce4util-$VERSION.tar.bz2"
cd libxfce4util-$VERSION

./configure --prefix=$PREFIX --sysconfdir=/etc
make && make install
