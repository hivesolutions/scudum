VERSION=${VERSION-4.10.1}
VERSION_L=${VERSION_L-4.10}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libwnck" "libxfce4ui" "libxfce4util" "startup-notification"

wget "http://archive.xfce.org/src/xfce/xfwm4/$VERSION_L/xfwm4-$VERSION.tar.bz2"
rm -rf xfwm4-$VERSION && tar -jxf "xfwm4-$VERSION.tar.bz2"
rm -f "xfwm4-$VERSION.tar.bz2"
cd xfwm4-$VERSION

./configure --prefix=$PREFIX
make && make install
