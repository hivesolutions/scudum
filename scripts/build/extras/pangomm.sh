VERSION=${VERSION-2.34.0}
VERSION_L=${VERSION_L-2.34}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "cairomm" "glibmm" "pango"

wget "http://ftp.gnome.org/pub/gnome/sources/pangomm/$VERSION_L/pangomm-$VERSION.tar.xz"
rm -rf pangomm-$VERSION && tar -Jxf "pangomm-$VERSION.tar.xz"
rm -f "pangomm-$VERSION.tar.xz"
cd pangomm-$VERSION

./configure --prefix=$PREFIX
make && make install
