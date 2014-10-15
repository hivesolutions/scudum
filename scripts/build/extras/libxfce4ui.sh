VERSION=${VERSION-4.10.0}
VERSION_L=${VERSION_L-4.10}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "gtk+2" "xfconf" "startup-notification"

wget "http://archive.xfce.org/src/xfce/libxfce4ui/$VERSION_L/libxfce4ui-$VERSION.tar.bz2"
rm -rf libxfce4ui-$VERSION && tar -jxf "libxfce4ui-$VERSION.tar.bz2"
rm -f "libxfce4ui-$VERSION.tar.bz2"
cd libxfce4ui-$VERSION

./configure --prefix=$PREFIX --sysconfdir=/etc
make && make install
