VERSION=${VERSION-2.24.4}
VERSION_L=${VERSION_L-2.24}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "atkmm" "gtk+2" "pangomm"

wget "http://ftp.gnome.org/pub/gnome/sources/gtkmm/$VERSION_L/gtkmm-$VERSION.tar.xz"
rm -rf gtkmm-$VERSION && tar -Jxf "gtkmm-$VERSION.tar.xz"
rm -f "gtkmm-$VERSION.tar.xz"
cd gtkmm-$VERSION

./configure --prefix=$PREFIX
make && make install
