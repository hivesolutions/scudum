VERSION=${VERSION-4.10.1}
VERSION_L=${VERSION_L-4.10}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "exo" "garcon" "libwnck" "libxfce4ui"

wget "http://archive.xfce.org/src/xfce/xfce4-panel/$VERSION_L/xfce4-panel-$VERSION.tar.bz2"
rm -rf xfce4-panel-$VERSION && tar -jxf "xfce4-panel-$VERSION.tar.bz2"
rm -f "xfce4-panel-$VERSION.tar.bz2"
cd xfce4-panel-$VERSION

./configure --prefix=$PREFIX --sysconfdir=/etc
make && make install
