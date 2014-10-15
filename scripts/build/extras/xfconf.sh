VERSION=${VERSION-4.10.0}
VERSION_L=${VERSION_L-4.10}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "dbux-glib" "libxfce4util"

wget "http://archive.xfce.org/src/xfce/xfconf/$VERSION_L/xfconf-$VERSION.tar.bz2"
rm -rf xfconf-$VERSION && tar -jxf "xfconf-$VERSION.tar.bz2"
rm -f "xfconf-$VERSION.tar.bz2"
cd xfconf-$VERSION

./configure --prefix=$PREFIX --disable-static
make && make install
