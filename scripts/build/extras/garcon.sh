VERSION=${VERSION-0.3.0}
VERSION_L=${VERSION_L-0.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libxfce4util" "gtk+2"

wget "http://archive.xfce.org/src/xfce/garcon/$VERSION_L/garcon-$VERSION.tar.bz2"
rm -rf garcon-$VERSION && tar -jxf "garcon-$VERSION.tar.bz2"
rm -f "garcon-$VERSION.tar.bz2"
cd garcon-$VERSION

./configure --prefix=$PREFIX --sysconfdir=/etc
make && make install
