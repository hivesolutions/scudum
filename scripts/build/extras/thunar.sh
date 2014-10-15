VERSION=${VERSION-1.6.3}
VERSION_L=${VERSION_L-1.6}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "exo" "libxfce4ui"

wget "http://archive.xfce.org/src/xfce/thunar/$VERSION_L/Thunar-$VERSION.tar.bz2"
rm -rf Thunar-$VERSION && tar -jxf "Thunar-$VERSION.tar.bz2"
rm -f "Thunar-$VERSION.tar.bz2"
cd Thunar-$VERSION

./configure --prefix=$PREFIX --sysconfdir=/etc
make && make install
