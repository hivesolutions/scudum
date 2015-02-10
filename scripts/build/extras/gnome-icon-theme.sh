VERSION=${VERSION-3.12.0}
VERSION_L=${VERSION_L-3.12}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "gtk+2" "hicolor-icon-theme"

wget "http://ftp.gnome.org/pub/gnome/sources/gnome-icon-theme/$VERSION_L/gnome-icon-theme-$VERSION.tar.xz"
rm -rf gnome-icon-theme-$VERSION && tar -Jxf "gnome-icon-theme-$VERSION.tar.xz"
rm -f "gnome-icon-theme-$VERSION.tar.xz"
cd gnome-icon-theme-$VERSION

./configure --prefix=$PREFIX
make && make install
